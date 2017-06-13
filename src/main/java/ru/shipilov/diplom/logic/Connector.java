package ru.shipilov.diplom.logic;


import ru.shipilov.diplom.logic.utils.Driver;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.TreeMap;

public class Connector {
    public Connector(String url, Driver driver, String usr, String pwd){
        if (url!=null) this.url = url;
//        this.url += this.nameDB;// + this.suffix;
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

    public boolean Done() {
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
        try {
            //getting line count
            Statement st = connection.createStatement();
            int lineCount = 0;
            ResultSet rs = st.executeQuery("select count(*) from " + tableName);
            while (rs.next()) {
                lineCount = rs.getInt(1);
            }
            table.setLineCount(lineCount);

            //getting column count
            rs = st.executeQuery("select * from " + tableName);
            ResultSetMetaData md = rs.getMetaData();
            int columnCount = md.getColumnCount();
            table.setColumnCount(columnCount);
            Map<String, Column> columns = new TreeMap();
            //getting columnTypes
            ArrayList types = new ArrayList();
            ArrayList isNullable = new ArrayList();
            for (int i = 1; i <= columnCount; i++) {
                Column column = new Column();
                Class c = Class.forName("a");
                Column ca = new Column<c>();
                String type = md.getColumnClassName(i);
                switch (type){
//                    case "java.sql.Clob":
//                    case "java.lang.String": column = new Column<String>();
//                    case "java.lang.Boolean": column = new Column<Boolean>();
//                    case "java.sqlTimestamp": column = new Column<Timestamp>();
//                    case "java.sql.Date": column = new Column<Date>();
                    case "java.lang.Integer": column = new Column<Integer>();
                    case "java.lang.Double": column = new Column<Double>();
                    case "java.lang.Long": column = new Column<Long>();
                }
                type = md.getColumnTypeName(i) + " " + md.getColumnDisplaySize(i);
                String name = md.getColumnName(i);
                column.setName(name);
                column.setColumnClassName(md.getColumnClassName(i));
                column.setType(type);
                column.setNullable(md.isNullable(i)==1);
                types.add(type);
                isNullable.add(md.isNullable(i));
                PreparedStatement preparedStatement = connection.prepareStatement("SELECT COUNT (DISTINCT "+name+") AS c FROM "+tableName);
                rs = preparedStatement.executeQuery();
                if (!rs.next())
                    column.setCountDistinctValues(0l);
                else
                    column.setCountDistinctValues(rs.getLong("c"));
                columns.put(name, column);
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
    private boolean res;
}
