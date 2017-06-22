package ru.shipilov.diplom.logic.utils;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import ru.shipilov.diplom.logic.Table;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.util.List;

public class XmlWorkerImpl implements XmlWorker{

    public DOMSource write(List<Table> tables){
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            Document doc = factory.newDocumentBuilder().getDOMImplementation().createDocument(null, "root", null);
            Element root = doc.getDocumentElement();

            if (tables != null && !tables.isEmpty()){
                for (Table table : tables){
                    root.appendChild(table.getElement(doc));
                }
            }

            return new DOMSource(doc);
        } catch (ParserConfigurationException ex){
            ex.printStackTrace();
        }
        return new DOMSource();
    }
}