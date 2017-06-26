package ru.shipilov.diplom.logic;


import ru.shipilov.diplom.logic.utils.Driver;
import ru.shipilov.diplom.logic.utils.PatternGenerator;
import ru.shipilov.diplom.logic.utils.QueryUtil;

import java.io.Closeable;
import java.sql.*;
import java.util.*;

public class Connector implements Closeable{
    private String url;
    private String schema;
    private Driver driver;
    private String user;
    private String password;
    private Connection connection = null;
    private Boolean res=false;

    public Connector(ru.shipilov.diplom.rest.entity.Connection connection){
        this.url = connection.getUrl();
        this.driver = connection.getDriver();
        this.user = connection.getUser();
        this.password = connection.getPassword();
        this.schema = connection.getSchema();
        try {
            Class.forName(this.driver.getFullName());
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        try {
            this.connection = DriverManager.getConnection(this.url, this.user, this.password);
            res = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public Boolean Done() {
        return res;
    }

    public List<String> getTableNames() {
        try {
            List mas = new ArrayList<String>();
            DatabaseMetaData dbm = this.connection.getMetaData();
            ResultSet rs = dbm.getTables(null, schema, "%", null);
            while (rs.next()) {
                String table = rs.getString("TABLE_NAME");
                mas.add(table);
            }
            return mas;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Table getTable(String tableName) {
        Table table = new Table();
        table.setName(tableName);
        try (Statement st = connection.createStatement()){
            //getting line count
            Long rowCount = QueryUtil.selectRowCount(connection, "*", tableName);
            table.setRowCount(rowCount);
            //getting column count
            ResultSet rs = st.executeQuery("select * from " + tableName);
            ResultSetMetaData md = rs.getMetaData();
            Integer columnCount = md.getColumnCount();
            table.setColumnCount(columnCount);
            Map<String, Column> columns = new TreeMap();
            //getting columnTypes
            for (int i = 1; i <= columnCount; i++) {
                rs = st.executeQuery("select * from " + tableName);
                md = rs.getMetaData();
                Column column = new Column();
                column.setNullable(md.isNullable(i)==1);
                String columnName = md.getColumnName(i);
                column.setName(columnName);
                String type = md.getColumnTypeName(i) + " " + md.getColumnDisplaySize(i);
                column.setType(type);
                column.setCountDistinctValues(QueryUtil.getCountDistinctValues(connection, columnName, tableName));
                type = md.getColumnClassName(i);
                column.setColumnClassName(type);
                if(column.getNullable()){
                    column.setCount(QueryUtil.selectRowCount(connection, columnName, tableName));
                }
                else
                    column.setCount(rowCount);
                columns.put(columnName, column);
            }
            table.addColumns(columns);

            //getting foreign keys
            DatabaseMetaData metaData = connection.getMetaData();
            ResultSet foreignKeys = metaData.getImportedKeys(connection.getCatalog(), null, tableName);
            while (foreignKeys.next()) {
                String fkTableName = foreignKeys.getString("FKTABLE_NAME");
                String fkColumnName = foreignKeys.getString("FKCOLUMN_NAME");
                String pkTableName = foreignKeys.getString("PKTABLE_NAME");
                String pkColumnName = foreignKeys.getString("PKCOLUMN_NAME");
                table.setFK(fkColumnName, pkTableName, pkColumnName);
            }

            //getting primary keys
            ResultSet primaryKeys = metaData.getPrimaryKeys(connection.getCatalog(), null, tableName);
            while (primaryKeys.next()){
                table.setPK(primaryKeys.getString("COLUMN_NAME"));
            }

            for (Column column:table.getColumnMap().values()){
                if (column.getCount()<100)
                    continue;
                String columnName = column.getName();
                if (column.getForeignKeyTable()!=null){//Если внешний ключ
                    Histogram histogram = QueryUtil.getHistogramWithMinMax(connection, columnName, tableName, true);
                    if(QueryUtil.getCountDistinctLinksCount(connection, columnName, tableName)>20){
                        histogram.udpateHistogram(column.getCount());
                        Long step = (Long)histogram.getStep();
                        histogram.setFrequencies(QueryUtil.getFrequenciesForFK(connection, columnName, tableName, step, histogram.getStepCount().intValue(), (Long)histogram.getMin(), (Long)histogram.getMax()));
                        histogram.calculateDispersion();
                        column.setListOfRareValues(QueryUtil.getNRareCountLinks(connection,columnName,tableName,10));
                    }
                    else{//числовой
                        histogram.setStepCount(column.getCount());
                        QueryUtil.getHistogramForNumericalSeries(connection, columnName, tableName, "java.lang.Long", histogram, true);
                    }
                    column.setHistogram(histogram);
                }
                else {
                    String type = column.getColumnClassName();
                    switch (type){
//                    case "java.sql.Clob":
                    case "java.lang.String":
                        List<String> values = QueryUtil.getAll(connection, columnName, tableName);
                        String[] res = new String[values.size()];
                        values.toArray(res);
                        HashMap<String, Long> map = PatternGenerator.getAllRegex(res);
                        Map.Entry<String, Long> maxEntry = null;
                        for (Map.Entry<String, Long> entry : map.entrySet()){
                            if (maxEntry == null || entry.getValue().compareTo(maxEntry.getValue()) > 0)
                                maxEntry = entry;
                        }
                        column.setPattern(maxEntry.getKey());
                        column.setPatternCount(maxEntry.getValue());
                        break;
//                    case "java.lang.Boolean": column = new Column<Boolean>();
//                    case "java.sqlTimestamp": column = new Column<Timestamp>();
//                    case "java.sql.Date": column = new Column<Date>();
                        case "java.lang.Integer":
                        case "java.lang.Double":
                        case "java.lang.Long":
                            if (column.isPrimary())
                                break;
                            Histogram histogram = QueryUtil.getHistogramWithMinMax(connection, columnName, tableName, false);
                            if (column.getCountDistinctValues()>20){
                                histogram.udpateHistogram(column.getCount());
                                Object step = histogram.getStep();
                                histogram.setFrequencies(QueryUtil.getFrequencies(connection, columnName, tableName, step, histogram.getStepCount().intValue(), histogram.getMin(), histogram.getMax()));
                                histogram.calculateDispersion();
                                column.setListOfRareValues(QueryUtil.getNRare(connection, columnName, tableName, 10));
                            }
                            else{//числовой
                                histogram.setStepCount(column.getCount());
                                QueryUtil.getHistogramForNumericalSeries(connection, columnName, tableName, type, histogram, false);
                            }
                            column.setHistogram(histogram);
                            break;
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        List<Column> columnList = new ArrayList<>();
        columnList.addAll(table.getColumnMap().values());
        table.setColumns(columnList);
        return table;
    }

    public void close(){
        try {
            if (!connection.isClosed())
                connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
