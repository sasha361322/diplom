package ru.shipilov.diplom.logic.utils;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public interface Xmlable {
    Element getElement(Document doc);
}
