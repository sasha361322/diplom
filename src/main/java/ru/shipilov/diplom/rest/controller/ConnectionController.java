package ru.shipilov.diplom.rest.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.shipilov.diplom.logic.ConnectorService;
import ru.shipilov.diplom.logic.Table;
import ru.shipilov.diplom.logic.utils.Driver;
import ru.shipilov.diplom.logic.utils.XmlWorker;
import ru.shipilov.diplom.logic.utils.XmlWorkerImpl;
import ru.shipilov.diplom.rest.entity.Connection;
import ru.shipilov.diplom.rest.service.ConnectionService;
import ru.shipilov.diplom.security.SecurityUtils;
import ru.shipilov.diplom.security.service.JwtUserDetailsServiceImpl;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("connection/")
public class ConnectionController {

    @Autowired
    JwtUserDetailsServiceImpl jwtUserDetailsService;

    @Autowired
    ConnectorService connectorService;

    @Autowired
    ConnectionService connectionService;

    @RequestMapping(value = "try", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity canConnect(@RequestBody Connection connection){
        if (connectorService.canConnect(connection)){
            return ResponseEntity.ok("Ok");
        }
        else
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Can't connect");
    }

    @RequestMapping(value = "add", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity addConnection(@RequestBody Connection connection){
        if (connectorService.canConnect(connection)){
            connectionService.save(connection);
            return ResponseEntity.ok("Ok");
        }
        else
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Can't connect");
    }

    @RequestMapping(value = "update", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity updateConnection(@RequestBody Connection connection){
        if (connectorService.canConnect(connection)){
            connectionService.update(connection);
            return ResponseEntity.ok("Ok");
        }
        else
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Can't update");
    }

    @RequestMapping(value = "delete/{connectionId}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity deleteConnection(@PathVariable Long connectionId){
        try{
            connectionService.delete(connectionId);
            return ResponseEntity.ok("Ok");
        }
        catch (Exception e){
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Can't delete");
        }
    }


    @RequestMapping(value = "get", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<Connection>> geConnections(){
        try{
            return new ResponseEntity<>(jwtUserDetailsService.loadUserByEmail(SecurityUtils.getCurrentUserLogin()).getConnections(),HttpStatus.OK);
        }
        catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @RequestMapping(value = "{connectionId}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Connection>getConnection(@PathVariable Long connectionId){
        try {
            return new ResponseEntity<>(connectionService.getById(connectionId), HttpStatus.OK);
        }
        catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "{connectionId}/tables", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<Table>> getAllTablesForConnection(@PathVariable Long connectionId){
        try {
            return new ResponseEntity<>(connectorService.getTables(connectionService.getById(connectionId)), HttpStatus.OK);
        }
        catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @RequestMapping(value = "drivers", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<Driver>> getDrivers(){
        try {
            return new ResponseEntity<>(Arrays.asList(Driver.values()), HttpStatus.OK);
        }
        catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @RequestMapping(path = "{connectionId}/download", method = RequestMethod.GET)
    public ResponseEntity<InputStreamResource> download(@PathVariable Long connectionId) throws IOException {
        File file = null;
        try {
            XmlWorker xmlWorker = new XmlWorkerImpl();
            DOMSource source = xmlWorker.write(connectorService.getTables(connectionService.getById(connectionId)));
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            file = File.createTempFile("file",".xml");
            file.deleteOnExit();
            StreamResult result = new StreamResult(file);
            transformer.transform(source, result);

            HttpHeaders headers = new HttpHeaders();
            headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
            headers.add("Pragma", "no-cache");
            headers.add("Expires", "0");
            headers.add("Content-disposition", "attachment; filename="+ file.getName());

            InputStreamResource resource = new InputStreamResource(new FileInputStream(file));

            return ResponseEntity.ok()
                    .headers(headers)
                    .contentLength(file.length())
                    .contentType(MediaType.parseMediaType("application/octet-stream"))
                    .body(resource);
        }catch (TransformerException ex){
            file.delete();
            ex.printStackTrace();
        }
        finally {
            file.delete();
        }
        return null;
    }
}
