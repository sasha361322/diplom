package ru.shipilov.diplom.rest.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import ru.shipilov.diplom.logic.ConnectorService;
import ru.shipilov.diplom.rest.entity.Connection;

@RestController
@RequestMapping("connection/")
public class ConnectionController {

    @Autowired
    ConnectorService connectorService;

    @RequestMapping(value = "try", method = RequestMethod.POST)
    public ResponseEntity canConnect(@ModelAttribute Connection connection){
        if (connectorService.canConnect(connection)){
            return ResponseEntity.ok("Ok");
        }
        else
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Can't connect");
    }

}
