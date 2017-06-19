package ru.shipilov.diplom.logic.utils;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import ru.shipilov.diplom.logic.Histogram;
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
//            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            Document doc = factory.newDocumentBuilder().getDOMImplementation().createDocument(null, "root", null);
            Element root = doc.getDocumentElement();

            if (tables != null && !tables.isEmpty()){
                for (Table table : tables){
//                    root.appendChild(getTableElement(doc, table));
                    root.appendChild(table.getElement(doc));// getTableElement(doc, table));
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

    private Element getHistogramElement(Document doc, Histogram histogram){

        Element histogramElement = doc.createElement("histogram");

        Element histogramMin = doc.createElement("min");
        histogramMin.appendChild(doc.createTextNode(histogram.getMin().toString()));
        histogramElement.appendChild(histogramMin);

        Element histogramMax = doc.createElement("max");
        histogramMax.appendChild(doc.createTextNode(histogram.getMax().toString()));
        histogramElement.appendChild(histogramMax);

        Element histogramStep = doc.createElement("step");
        histogramStep.appendChild(doc.createTextNode(histogram.getStep().toString()));
        histogramElement.appendChild(histogramStep);

        Element histogramStepCount = doc.createElement("stepCount");
        histogramStepCount.appendChild(doc.createTextNode(histogram.getStepCount().toString()));
        histogramElement.appendChild(histogramStepCount);

        Element histogramFrequencies = doc.createElement("frequencies");
        for (Long item : histogram.getFrequencies()){
            Element value = doc.createElement("value");
            value.appendChild(doc.createTextNode(item.toString()));
            histogramFrequencies.appendChild(value);
        }
        histogramElement.appendChild(histogramFrequencies);

        Element expectetion = doc.createElement("expectetion");
        expectetion.appendChild(doc.createTextNode(histogram.getExpectation().toString()));
        histogramElement.appendChild(expectetion);

        Element dispersion = doc.createElement("dispersion");
        dispersion.appendChild(doc.createTextNode(histogram.getDispersion().toString()));
        histogramElement.appendChild(dispersion);

        return histogramElement;
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
}
