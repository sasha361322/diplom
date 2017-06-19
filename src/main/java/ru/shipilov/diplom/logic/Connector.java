package ru.shipilov.diplom.logic;


import org.springframework.stereotype.Service;
import ru.shipilov.diplom.logic.utils.Driver;
import ru.shipilov.diplom.logic.utils.QueryUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.Map;
import java.util.TreeMap;

@Service
public class Connector {
    public Connector(String url, Driver driver, String usr, String pwd){
        if (url!=null) this.url = url;
        if (driver!=null)this.driver = driver;
        if (usr!=null)this.usr = usr;
        if (pwd!=null)this.pwd = pwd;
        res = false;
        try {
            Class.forName(this.driver.getFullName());
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        try {
            this.connection = DriverManager.getConnection(this.url, this.usr, this.pwd);
            res = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public Connector(String url, Driver driver){
        this(url, driver, null, null);
    }

    public Connector(){
        this(null, null);
    }

    public Boolean Done() {
        return res;
    }

    public ArrayList<String> getTableNames() {
        try {
            ArrayList mas = new ArrayList<String>();
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
            ArrayList isNullable = new ArrayList();
            for (int i = 1; i <= columnCount; i++) {
                rs = st.executeQuery("select * from " + tableName);
                md = rs.getMetaData();
                Column column = new Column();
                column.setNullable(md.isNullable(i)==1);
                String columnName = md.getColumnName(i);
                column.setName(columnName);
                String type = md.getColumnTypeName(i) + " " + md.getColumnDisplaySize(i);
                column.setColumnClassName(md.getColumnClassName(i));
                column.setType(type);
                isNullable.add(md.isNullable(i));
                column.setCountDistinctValues(QueryUtil.getCountDistinctValues(connection, columnName, tableName));
                type = md.getColumnClassName(i);
                column.setJavaType(type);
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
                System.out.println(fkTableName + "." + fkColumnName + " -> " + pkTableName + "." + pkColumnName);
            }

            //getting primary keys
            ResultSet primaryKeys = metaData.getPrimaryKeys(connection.getCatalog(), null, tableName);
            while (primaryKeys.next()){
                table.setPK(primaryKeys.getString("COLUMN_NAME"));
            }

            for (Column column:table.getColumns().values()){
                if ((!column.isPrimary())&&(column.getCount()>100)){
                    String columnName = column.getName();
                    String type = column.getJavaType();
                    switch (type){
//                    case "java.sql.Clob":
//                    case "java.lang.String": column = new Column<String>();
//                    case "java.lang.Boolean": column = new Column<Boolean>();
//                    case "java.sqlTimestamp": column = new Column<Timestamp>();
//                    case "java.sql.Date": column = new Column<Date>();
                        case "java.lang.Integer":
                        case "java.lang.Double":
                        case "java.lang.Long":
                                Histogram histogram = QueryUtil.getHistogramWithMinMax(connection, columnName, tableName, column.getForeignKeyTable()!=null);
                                if (column.getCountDistinctValues()>20) {//Интервальный ряд
                                    histogram.udpateHistogram(column.getCount());
                                    Object step = histogram.getStep();
                                    //поменять для fk
                                    histogram.setFrequencies(QueryUtil.getFrequencies(connection, columnName, tableName, step, histogram.getStepCount().intValue(), histogram.getMin(), histogram.getMax()));
                                    histogram.calculateDispersion();
                                    column.setListOfRareValues(QueryUtil.getNRare(connection, columnName, tableName, 10));
                                }
                                else{//числовой
                                    histogram.setStepCount(column.getCount());
                                    QueryUtil.getHistogramForNumericalSeries(connection, columnName, tableName, type, histogram);
                                }
                                column.setHistogram(histogram);
                            break;
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return table;
    }


    private String url= "jdbc:mysql://localhost:3306/";
//    private String suffix = "?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
    private String schema = "PUBLIC";
    private Driver driver = Driver.mysql;
    private String usr = "root";
    private String pwd = "";
    private Connection connection = null;
    private Boolean res;
}
