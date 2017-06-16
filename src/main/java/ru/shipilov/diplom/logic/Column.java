package ru.shipilov.diplom.logic;


import ru.shipilov.diplom.logic.utils.Histogtam;

import java.util.List;

public class Column {
    private String name;
    private boolean isNullable;
    private String type;
    private boolean isPrimary;
    private String foreignKeyTable;
    private String foreignKeyColumn;
    private Long countDistinctValues;
    private Long count;
    private Histogtam histogram;
    private List listOfRareValues;

    public Long getCountDistinctValues() {
        return countDistinctValues;
    }

    public void setCountDistinctValues(Long countDistinctValues) {
        this.countDistinctValues = countDistinctValues;
    }

    public String getForeignKeyTable() {
        return foreignKeyTable;
    }

    public void setForeignKeyTable(String foreignKeyTable) {
        this.foreignKeyTable = foreignKeyTable;
    }

    public String getForeignKeyColumn() {
        return foreignKeyColumn;
    }

    public void setForeignKeyColumn(String foreignKeyColumn) {
        this.foreignKeyColumn = foreignKeyColumn;
    }

    private String columnClassName;

    @Override
    public String toString() {
        return "\n\tColumn{\n\t\t" +
                "name='" + name + '\'' +
                ", isNullable=" + isNullable +
                ", type='" + type + '\'' +
                ", isPrimary=" + isPrimary +
                ", foreignKey=" + foreignKeyTable +
                '.' + foreignKeyColumn +
                ", columnClassName='" + columnClassName + '\'' +
                ", countDistinctValues='" + countDistinctValues + '\'' +
                "\n}";
    }

    public void setForeignKey(String foreignKeyTable, String foreignKeyColumn){
        this.foreignKeyColumn = foreignKeyColumn;
        this.foreignKeyTable = foreignKeyTable;
    }

    public String getColumnClassName() {
        return columnClassName;
    }

    public void setColumnClassName(String columnClassName) {
        this.columnClassName = columnClassName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isNullable() {
        return isNullable;
    }

    public void setNullable(boolean aNull) {
        isNullable = aNull;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean isPrimary() {
        return isPrimary;
    }

    public void setPrimary(boolean primary) {
        isPrimary = primary;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public Histogtam getHistogram() {
        return histogram;
    }

    public void setHistogram(Histogtam histogram) {
        this.histogram = histogram;
    }

    public List getListOfRareValues() {
        return listOfRareValues;
    }

    public void setListOfRareValues(List listOfRareValues) {
        this.listOfRareValues = listOfRareValues;
    }
}

