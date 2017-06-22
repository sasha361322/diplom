package ru.shipilov.diplom.rest.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.shipilov.diplom.logic.ConnectorService;
import ru.shipilov.diplom.logic.Table;
import ru.shipilov.diplom.rest.entity.Connection;
import ru.shipilov.diplom.rest.service.ConnectionService;
import ru.shipilov.diplom.security.SecurityUtils;
import ru.shipilov.diplom.security.service.JwtUserDetailsServiceImpl;

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
            return ResponseEntity.ok("Ok");
        }
        else
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Can't connect");
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

}
