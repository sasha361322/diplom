package ru.shipilov.diplom.logic;

import java.util.Map;

public class Table {
    public void setPK(String name){
        columns.get(name).setPrimary(true);
    }
    public void setFK(String columnName, String foreignKeyTable, String foreignKeyColumn){
        columns.get(columnName).setForeignKey(foreignKeyTable, foreignKeyColumn);
    }
    @Override
    public String toString() {
        return "Table{" +
                "name='" + name + '\'' +
                ", columnCount=" + columnCount +
                ", lineCount=" + lineCount +
                ", columns=\r\n" + columns +
                "\n}\n";
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getColumnCount() {
        return columnCount;
    }

    public void setColumnCount(int columnCount) {
        this.columnCount = columnCount;
    }

    public int getLineCount() {
        return lineCount;
    }

    public void setLineCount(int lineCount) {
        this.lineCount = lineCount;
    }

    public Map<String, Column> getColumns() {
        return columns;
    }

    public void setColumns(Map<String, Column> columns) {
        this.columns = columns;
    }

    public void addColumns(Map<String, Column> columns) {
        if(this.columns==null)
            this.columns = columns;
        else
            this.columns.putAll(columns);

    }

    private String name;
    private int columnCount;
    private int lineCount;
    private Map<String,Column> columns;
}