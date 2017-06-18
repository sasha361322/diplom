package ru.shipilov.diplom.logic.utils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class QueryUtil {

    public static Long selectRowCount(Connection connection, String columnName, String tableName){
        return QueryUtil.executeQuery(connection, "SELECT " +
                "CASE WHEN COUNT("+columnName+") IS NULL" +
                " THEN 0 " +
                "ELSE COUNT("+columnName+")" +
                " END AS C" +
                " FROM "+ tableName);
    }

    public static Long getCountDistinctValues(Connection connection, String columnName, String tableName){
        return QueryUtil.executeQuery(connection,"SELECT COUNT (DISTINCT "+columnName+") FROM "+tableName);
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
