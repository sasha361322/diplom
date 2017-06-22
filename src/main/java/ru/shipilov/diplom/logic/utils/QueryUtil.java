package ru.shipilov.diplom.logic.utils;

import ru.shipilov.diplom.logic.Histogram;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class QueryUtil {
    public static List<String> getAll(Connection connection, String columnName, String tableName) {
        try (Statement statement = connection.createStatement()){
            ResultSet resultSet = statement.executeQuery("SELECT "+columnName+" FROM "+tableName+";");
            List<String> res = new ArrayList<>();
            while(resultSet.next()){
                res.add(resultSet.getString(1));
            }
            return res;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public static Long selectRowCount(Connection connection, String columnName, String tableName){
        return QueryUtil.executeQuery(connection, "SELECT " +
                "CASE WHEN COUNT("+columnName+") IS NULL" +
                " THEN 0 " +
                "ELSE COUNT("+columnName+")" +
                " END AS C" +
                " FROM "+ tableName);
    }
    public static Long getCountDistinctLinksCount(Connection connection, String columnName, String tableName){
        return QueryUtil.executeQuery(connection,"SELECT COUNT (DISTINCT CNT)\n" +
                "  FROM(\n" +
                "    SELECT " + columnName + ", COUNT(" + columnName + " ) AS CNT\n" +
                "      FROM " + tableName + " \n" +
                "      GROUP BY " + columnName + "\n" +
                "  );");
    }
    public static List<Long> getFrequenciesForFK(Connection connection, String columnName, String tableName, Long step, Integer stepCount, Long min,  Long max){

        List<Long> frequencies = new ArrayList<>();

        for (int j = 0; j < stepCount - 1; j++) {
            frequencies.add(QueryUtil.getLinkCountBetween(connection, columnName, tableName,  min + step * j,  min + step * (j + 1)));
        }
        frequencies.add(QueryUtil.getLinkCountBetween(connection, columnName, tableName,  min +  step * (stepCount - 1), max));
        return frequencies;
    }
    public static Long getLinkCountBetween(Connection connection, String columnName, String tableName, Long from, Long to){
        return executeQuery(connection, "SELECT COUNT(CNT) \n" +
                "FROM(\n" +
                "  SELECT " + columnName + ", COUNT(" + columnName + ") AS CNT\n" +
                "  FROM " + tableName + " \n" +
                "  GROUP BY " + columnName + ")\n" +
                "WHERE CNT BETWEEN "+from+" AND "+to+";");
    }
    public static Histogram getHistogramWithMinMax(Connection connection, String columnName, String tableName, Boolean isFK){
        try (Statement statement = connection.createStatement()){
            Object min=0, max=0;
            ResultSet rs = statement.executeQuery(!isFK
                    ?"SELECT min(" + columnName + ") as MIN, max(" + columnName + ") as MAX FROM " + tableName

                    :"SELECT MIN(CNT) AS MIN, MAX(CNT) AS MAX\n" +
                    "FROM(\n" +
                    "  SELECT " + columnName + ", COUNT(" + columnName + ") AS CNT\n" +
                    "  FROM " + tableName + " \n" +
                    "  GROUP BY " + columnName + "\n" +
                    ");");
            if (rs.next()) {
                min = rs.getObject("MIN");
                max = rs.getObject("MAX");
            }
            return new Histogram(min, max);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Histogram getHistogramForNumericalSeries(Connection connection, String columnName, String tableName, String type, Histogram histogram, Boolean isFk){
        try (Statement statement = connection.createStatement()){
            ResultSet resultSet = statement.executeQuery(!isFk ?
                    "SELECT "+columnName+", COUNT("+columnName+")  \n" +
                    "FROM "+tableName+" \n" +
                    "GROUP BY "+columnName+" \n"+
                    "ORDER BY "+columnName
                    :"SELECT CNT, COUNT(CNT)\n" +
                    "FROM\n" +
                    "(SELECT "+columnName+" , COUNT("+columnName+") AS CNT\n" +
                    "FROM "+tableName+" \n" +
                    "GROUP BY "+columnName+") \n" +
                    "GROUP BY CNT;");
            List values = new ArrayList();
            List<Double> frequencies = new ArrayList();
            Long count = histogram.getStepCount();
            while(resultSet.next()){
                values.add(resultSet.getObject(1));
                Long l = resultSet.getLong(2);
                frequencies.add(l*1.0/count);
            }
            histogram.updatehistogram(values, frequencies, type);
            return histogram;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Long getCountDistinctValues(Connection connection, String columnName, String tableName){
        return QueryUtil.executeQuery(connection,"SELECT COUNT (DISTINCT "+columnName+") FROM "+tableName);
    }

    public static List<Long> getNRareCountLinks(Connection connection, String columnName, String tableName, Integer n){
        try (Statement statement = connection.createStatement()){
            ResultSet resultSet = statement.executeQuery("SELECT CNT, COUNT(CNT) " +
                    "FROM(\n" +
                    "  SELECT " + columnName + ", COUNT(" + columnName + ") AS CNT\n" +
                    "  FROM " + tableName + " \n" +
                    "  GROUP BY " + columnName + "\n" +
                    ")" +
                    "GROUP BY CNT\n" +
                    "  ORDER BY COUNT(CNT) DESC LIMIT "+n+";");
            List<Long> list = new ArrayList();
            while(resultSet.next()){
                list.add(resultSet.getLong(1));
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public static List getNRare(Connection connection, String columnName, String tableName, Integer n){
        try (Statement statement = connection.createStatement()){
            ResultSet resultSet = statement.executeQuery("SELECT "+columnName+", COUNT("+columnName+") FROM "+tableName+" GROUP BY "+columnName+" ORDER BY COUNT("+columnName+") DESC LIMIT "+n);
            List list = new ArrayList();
            while(resultSet.next()){
                list.add(resultSet.getObject(1));
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Long executeQuery(Connection connection, String query){
        try (Statement statement = connection.createStatement()){
            ResultSet resultSet = statement.executeQuery(query);
            if(resultSet.next()){
                return resultSet.getLong(1);
            }
            return 0l;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0l;
    }

    public static Long getCountBetween(Connection connection, String columnName, String tableName, Object from, Object to){
        try (Statement statement = connection.createStatement()){
            ResultSet resultSet = null;
            if (from instanceof Long)
                resultSet = statement.executeQuery("SELECT COUNT("+columnName+") FROM "+tableName+" WHERE "+columnName+" BETWEEN "+(Long)from+" AND "+(Long)to);
            else if (from instanceof Integer)
                resultSet = statement.executeQuery("SELECT COUNT("+columnName+") FROM "+tableName+" WHERE "+columnName+" BETWEEN "+(Integer)from+" AND "+(Integer)to);
            else if (from instanceof Double)
                resultSet = statement.executeQuery("SELECT COUNT("+columnName+") FROM "+tableName+" WHERE "+columnName+" BETWEEN "+(Double)from+" AND "+(Double)to);
            if(resultSet.next()){
                return resultSet.getLong(1);
            }
            return 0l;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0l;
    }

    public static List<Long> getFrequencies(Connection connection, String columnName, String tableName, Object step, Integer stepCount, Object min, Object max) {
        List<Long> frequencies = new ArrayList<>();
        if ((min instanceof Long)&&(max instanceof Long)) {

            for (int j = 0; j < stepCount - 1; j++) {
                frequencies.add(QueryUtil.getCountBetween(connection, columnName, tableName, (Long) min + (Long) step * j, (Long) min + (Long) step * (j + 1)));
            }
            frequencies.add(QueryUtil.getCountBetween(connection, columnName, tableName, (Long) min + (Long) step * (stepCount - 1), max));
        }
        else if ((min instanceof Integer)&&(max instanceof Integer)) {

            for (int j = 0; j < stepCount - 1; j++) {
                frequencies.add(QueryUtil.getCountBetween(connection, columnName, tableName, (Integer) min + (Integer) step * j, (Integer) min + (Integer) step * (j + 1)));
            }
            frequencies.add(QueryUtil.getCountBetween(connection, columnName, tableName, (Integer) min + (Integer) step * (stepCount - 1), max));
        }
        else if ((min instanceof Double)&&(max instanceof Double)) {

            for (int j = 0; j < stepCount - 1; j++) {
                frequencies.add(QueryUtil.getCountBetween(connection, columnName, tableName, (Double) min + (Double) step * j, (Double) min + (Double) step * (j + 1)));
            }
            frequencies.add(QueryUtil.getCountBetween(connection, columnName, tableName, (Double) min + (Double) step * (stepCount - 1), max));
        }
        else
            return null;
        return frequencies;
    }
}
