package ru.shipilov.diplom.rest.service;

import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.shipilov.diplom.rest.entity.Connection;
import ru.shipilov.diplom.rest.repository.ConnectionRepository;
import ru.shipilov.diplom.security.SecurityUtils;
import ru.shipilov.diplom.security.entity.AuthUser;
import ru.shipilov.diplom.security.repository.AuthUserRepository;

import javax.transaction.Transactional;
import java.util.List;


@Service
public class ConnectionService {

    @Autowired
    private ConnectionRepository repository;

    @Autowired
    private AuthUserRepository authUserRepository;

    @Transactional
    public Connection getById(Long id){
        Connection connection = repository.getById(id);
        if(connection.getAuthUser()==authUserRepository.findByEmail(SecurityUtils.getCurrentUserLogin()))
            return connection;
        else
            return null;
    }

    @Transactional
    public List<Connection> getAll(){
        return Lists.newArrayList(repository.findAll());
    }

    @Transactional
    public Connection save(Connection connection){
        return repository.save(connection);
    }

    @Transactional
    public List <Connection> save(List<Connection> connections){
        for (Connection connection : connections){
            save(connection);
        }
        return connections;
    }

    @Transactional
    public void delete(Long id){
        repository.deleteById(id);
    }

    @Transactional
    public List<Connection> getAllForUser(AuthUser user){
        return repository.getAllByAuthUser(user);
    }

    @Transactional
    public void update (Connection connections){
        repository.save(connections);
    }
}
