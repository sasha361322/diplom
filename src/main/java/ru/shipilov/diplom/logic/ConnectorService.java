package ru.shipilov.diplom.logic;

import org.springframework.stereotype.Service;
import ru.shipilov.diplom.rest.entity.Connection;

@Service
public class ConnectorService {

    public Boolean canConnect(Connection connection){
        Connector connector = new Connector(connection);
        connector.close();
        return connector.Done();
    }
}
