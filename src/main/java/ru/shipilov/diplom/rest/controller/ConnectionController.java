package ru.shipilov.diplom.rest.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import ru.shipilov.diplom.logic.ConnectorService;
import ru.shipilov.diplom.rest.entity.Connection;
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

    @RequestMapping(value = "try", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity canConnect(@RequestBody Connection connection){
        System.out.println(connection);
        if (connectorService.canConnect(connection)){
            return ResponseEntity.ok("Ok");
        }
        else
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Can't connect");
    }

    @RequestMapping(value = "get", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Connection> geConnections(){
        return jwtUserDetailsService.loadUserByEmail(SecurityUtils.getCurrentUserLogin()).getConnections();
    }

}
