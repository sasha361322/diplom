package ru.shipilov.diplom.logic;

import org.springframework.stereotype.Service;
import ru.shipilov.diplom.rest.entity.Connection;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ConnectorService {

    public Boolean canConnect(Connection connection){
        try(Connector connector = new Connector(connection)){
            return connector.Done();
        }
        catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public List<Table> getTables(Connection connection){
        try(Connector connector = new Connector(connection)){
            return connector.getTableNames().stream()
                    .map(name->connector.getTable(name))
                    .collect(Collectors.toList());
        }
        catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
