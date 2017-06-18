package ru.shipilov.diplom.logic.utils;

import ru.shipilov.diplom.logic.Table;

import java.util.List;

public interface XmlWorker {
    void write(List<Table> tables, String path);
}
