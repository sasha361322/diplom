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

    public void write(List<Table> tables, String path){
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

            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "2");

            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(new File(path));
            transformer.transform(source, result);

        } catch (ParserConfigurationException ex){
            ex.printStackTrace();
        } catch (TransformerException tex){
            tex.printStackTrace();
        }
    }
}