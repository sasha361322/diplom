package ru.shipilov.diplom.logic.utils;

import ru.shipilov.diplom.logic.Table;

import javax.xml.transform.dom.DOMSource;
import java.util.List;

public interface XmlWorker {
    DOMSource write(List<Table> tables);
}
