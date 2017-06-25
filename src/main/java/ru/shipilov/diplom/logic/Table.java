package ru.shipilov.diplom.logic;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import ru.shipilov.diplom.logic.utils.Xmlable;

import java.util.List;
import java.util.Map;

public class Table implements Xmlable {
    private String name;
    private Integer columnCount;
    private Long rowCount;
    @JsonIgnore
    private Map<String,Column> columnMap;
    private List<Column> columns;

    @Override
    public Element getElement(Document doc) {

        Element tableElement = doc.createElement("table");

        Element tableName = doc.createElement("name");
        tableName.appendChild(doc.createTextNode(this.name));
        tableElement.appendChild(tableName);

        Element columnCount = doc.createElement("columnCount");
        columnCount.appendChild(doc.createTextNode(this.columnCount.toString()));
        tableElement.appendChild(columnCount);

        Element rowCount = doc.createElement("rowCount");
        rowCount.appendChild(doc.createTextNode(this.rowCount.toString()));
        tableElement.appendChild(rowCount);

        //add columnMap
        if (columnMap != null && !columnMap.isEmpty()){
            for (Column column : columnMap.values()){
                tableElement.appendChild(column.getElement(doc));
            }
        }
        return tableElement;
    }


    public void setPK(String name){
        columnMap.get(name).setPrimary(true);
    }

    public void setFK(String columnName, String foreignKeyTable, String foreignKeyColumn){
        columnMap.get(columnName).setForeignKey(foreignKeyTable, foreignKeyColumn);
    }

    public void addColumns(Map<String, Column> columns) {
        if(this.columnMap ==null)
            this.columnMap = columns;
        else
            this.columnMap.putAll(columns);

    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getColumnCount() {
        return columnCount;
    }

    public void setColumnCount(Integer columnCount) {
        this.columnCount = columnCount;
    }

    public Long getRowCount() {
        return rowCount;
    }

    public void setRowCount(Long rowCount) {
        this.rowCount = rowCount;
    }

    public Map<String, Column> getColumnMap() {
        return columnMap;
    }

    public void setColumnMap(Map<String, Column> columnMap) {
        this.columnMap = columnMap;
    }

    public List<Column> getColumns() {
        return columns;
    }

    public void setColumns(List<Column> columns) {
        this.columns = columns;
    }
}