package ru.shipilov.diplom.logic;

import org.apache.catalina.connector.Connector;

public class Main {
    public static void main(String[] args) {
        Connector connector = new Connector();
        System.out.println(connector.Done());
        System.out.println(connector.getTableNames());
        int cnt = connector.getTableNames().size();
        for (String name : connector.getTableNames()) {
            Table table = connector.getTable(name);
            System.out.println(table);
        }
    }
}
