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
//    @RequestMapping(path = "/download", method = RequestMethod.GET)
//    public ResponseEntity<InputStreamResource> download() throws IOException {
//
//        File file = new File("C:\\Users\\1\\Desktop\\Prog\\ДИПЛОМ\\Sasha\\src\\main\\resources\\file.xml");
//        HttpHeaders headers = new HttpHeaders();
//        headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
//        headers.add("Pragma", "no-cache");
//        headers.add("Expires", "0");
//
//        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
//
//        return ResponseEntity.ok()
//                .headers(headers)
//                .contentLength(file.length())
//                .contentType(MediaType.parseMediaType("application/octet-stream"))
//                .body(resource);
//    }