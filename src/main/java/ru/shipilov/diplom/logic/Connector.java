package ru.shipilov.diplom.logic;


import ru.shipilov.diplom.logic.utils.Driver;
import ru.shipilov.diplom.logic.utils.Histogtam;

import java.sql.*;
import java.util.ArrayList;
import java.util.Map;
import java.util.TreeMap;

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
            ArrayList isNullable = new ArrayList();
            for (int i = 1; i <= columnCount; i++) {
                Column column = new Column();
                Class c = Class.forName("a");
                Column ca = new Column();
                String type = md.getColumnClassName(i);
                column.setNullable(md.isNullable(i)==1);
                String name = md.getColumnName(i);
                column.setName(name);
                if(column.isNullable()){
                    rs = st.executeQuery("SELECT COUNT("+name+") AS c FROM "+ tableName);//http://univer-nn.ru/zadachi-po-statistike-primeri/gruppirovka-formula-sterdzhessa/
                }
                if (rs.next())
                    column.setCount(rs.getLong("c"));
                else
                    column.setCount(0l);
                switch (type){
//                    case "java.sql.Clob":
//                    case "java.lang.String": column = new Column<String>();
//                    case "java.lang.Boolean": column = new Column<Boolean>();
//                    case "java.sqlTimestamp": column = new Column<Timestamp>();
//                    case "java.sql.Date": column = new Column<Date>();
                    case "java.lang.Integer":
                        rs = st.executeQuery("SELECT min("+name+") as min, max("+name+") as max FROM "+tableName);
                        Integer imin=0, imax=0;
                        if (rs.next()){
                            imin = rs.getInt("min");
                            imax = rs.getInt("max");
                        }
                        column.setHistogram(new Histogtam(imin, imax, column.getCount()));
                    break;
                    case "java.lang.Double":
                        rs = st.executeQuery("SELECT min("+name+") as min, max("+name+") as max FROM "+tableName);
                        Double dmin=0.0, dmax=0.0;
                        if (rs.next()){
                            dmin = rs.getDouble("min");
                            dmax = rs.getDouble("max");
                        }
                        column.setHistogram(new Histogtam(dmin, dmax, column.getCount()));
                        break;
                    case "java.lang.Long":
                        rs = st.executeQuery("SELECT min("+name+") as min, max("+name+") as max FROM "+tableName);
                        Long min=0l, max=0l;
                        if (rs.next()){
                            min = rs.getLong("min");
                            max = rs.getLong("max");
                        }
                        column.setHistogram(new Histogtam(min, max, column.getCount()));
                        break;
                }
                type = md.getColumnTypeName(i) + " " + md.getColumnDisplaySize(i);
                column.setColumnClassName(md.getColumnClassName(i));
                column.setType(type);
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
