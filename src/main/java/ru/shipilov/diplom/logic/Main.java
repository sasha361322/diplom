package ru.shipilov.diplom.logic;


import ru.shipilov.diplom.logic.utils.Driver;
import ru.shipilov.diplom.logic.utils.XmlWorkerImpl;

import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        Connector connector = new Connector("jdbc:h2:.\\db\\db", Driver.H2, "sa","");
        System.out.println(connector.Done());
        System.out.println(connector.getTableNames());
        int cnt = connector.getTableNames().size();
        List<Table> tables = new ArrayList<>();
        for (String name : connector.getTableNames()) {
            Table table = connector.getTable(name);
            tables.add(table);
            System.out.println(table);
        }
        XmlWorkerImpl xmlWorker = new XmlWorkerImpl();
        xmlWorker.write(tables, "./1.xml");
    }
}
