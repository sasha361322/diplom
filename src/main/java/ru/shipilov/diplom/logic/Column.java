package ru.shipilov.diplom.logic;


public class Column {
    private String name;
    private boolean isNullable;
    private String type;
    private boolean isPrimary;
    private String foreignKeyTable;
    private String foreignKeyColumn;

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

}

