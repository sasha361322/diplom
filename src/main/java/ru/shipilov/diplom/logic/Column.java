package ru.shipilov.diplom.logic;


import com.fasterxml.jackson.annotation.JsonInclude;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import ru.shipilov.diplom.logic.utils.Xmlable;

import java.util.List;

public class Column implements Xmlable {
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String name;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Boolean isNullable;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String type;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Boolean isPrimary=false;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String foreignKeyTable;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String foreignKeyColumn;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Long countDistinctValues;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Long count;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private List listOfRareValues;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String columnClassName;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Histogram histogram;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String pattern;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Long patternCount;

    @Override
    public Element getElement(Document doc) {
        Element columnElement = doc.createElement("column");

        Element columnName = doc.createElement("name");
        columnName.appendChild(doc.createTextNode(this.name));
        columnElement.appendChild(columnName);

        Element isNullable = doc.createElement("nullable");
        isNullable.appendChild(doc.createTextNode(this.isNullable.toString()));
        columnElement.appendChild(isNullable);

        Element type = doc.createElement("type");
        type.appendChild(doc.createTextNode(this.type));
        columnElement.appendChild(type);

        Element isPrimary = doc.createElement("primary");
        isPrimary.appendChild(doc.createTextNode(this.isPrimary.toString()));
        columnElement.appendChild(isPrimary);

        if (foreignKeyTable != null){
            Element foreignKeyTable = doc.createElement("foreignKeyTable");
            foreignKeyTable.appendChild(doc.createTextNode(this.foreignKeyTable));
            columnElement.appendChild(foreignKeyTable);
        }

        if (foreignKeyColumn != null){
            Element foreignKeyColumn = doc.createElement("foreignKeyColumn");
            foreignKeyColumn.appendChild(doc.createTextNode(this.foreignKeyColumn));
            columnElement.appendChild(foreignKeyColumn);
        }

        Element countDistinctValues = doc.createElement("countDistinctValues");
        countDistinctValues.appendChild(doc.createTextNode(this.countDistinctValues.toString()));
        columnElement.appendChild(countDistinctValues);

        Element count = doc.createElement("count");
        count.appendChild(doc.createTextNode(this.count.toString()));
        columnElement.appendChild(count);

        if (this.listOfRareValues != null && !this.listOfRareValues.isEmpty()){
            Element listOfRareValues = doc.createElement("listOfRareValues");
            for (Object value : this.listOfRareValues){
                Element valueElement = doc.createElement("value");
                valueElement.appendChild(doc.createTextNode(value.toString()));
                listOfRareValues.appendChild(valueElement);
            }
            columnElement.appendChild(listOfRareValues);
        }

        Element javaType = doc.createElement("className");
        javaType.appendChild(doc.createTextNode(this.columnClassName.toString()));
        columnElement.appendChild(javaType);

        if (this.pattern!=null){
            Element pattern = doc.createElement("pattern");
            pattern.appendChild(doc.createTextNode(this.pattern.toString()));
            pattern.setAttribute("count", this.patternCount.toString());
            columnElement.appendChild(pattern);
        }

        if (this.histogram != null){
            columnElement.appendChild(this.histogram.getElement(doc));
        }

        return columnElement;
    }

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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Boolean isPrimary() {
        return isPrimary;
    }

    public void setPrimary(Boolean primary) {
        isPrimary = primary;
    }

    public Boolean getPrimary() {
        return isPrimary;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public Histogram getHistogram() {
        return histogram;
    }

    public void setHistogram(Histogram histogram) {
        this.histogram = histogram;
    }

    public List getListOfRareValues() {
        return listOfRareValues;
    }

    public void setListOfRareValues(List listOfRareValues) {
        this.listOfRareValues = listOfRareValues;
    }

    public void setNullable(Boolean nullable) {
        isNullable = nullable;
    }

    public Boolean getNullable() {
        return isNullable;
    }

    public String getPattern() {
        return pattern;
    }

    public void setPattern(String pattern) {
        this.pattern = pattern;
    }

    public Long getPatternCount() {
        return patternCount;
    }

    public void setPatternCount(Long patternCount) {
        this.patternCount = patternCount;
    }
}

