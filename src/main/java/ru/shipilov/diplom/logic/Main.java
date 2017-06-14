package ru.shipilov.diplom.logic;


import ru.shipilov.diplom.logic.utils.Driver;

public class Main {
    public static void main(String[] args) {
//        Connector connector = new Connector();
        Connector connector = new Connector("jdbc:h2:.\\db\\db", Driver.h2, "sa","");
        System.out.println(connector.Done());
        System.out.println(connector.getTableNames());
        int cnt = connector.getTableNames().size();
        for (String name : connector.getTableNames()) {
            Table table = connector.getTable(name);
            System.out.println(table);
        }
    }
}
