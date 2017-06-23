package ru.shipilov.diplom.rest.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.shipilov.diplom.rest.entity.Connection;
import ru.shipilov.diplom.rest.repository.ConnectionRepository;
import ru.shipilov.diplom.security.SecurityUtils;
import ru.shipilov.diplom.security.repository.AuthUserRepository;



@Service
public class ConnectionService {

    @Autowired
    private ConnectionRepository repository;

    @Autowired
    private AuthUserRepository authUserRepository;

    @Transactional(readOnly = true)
    public Connection getById(Long id){
        Connection connection = repository.getById(id);
        if(connection.getAuthUser()==authUserRepository.findByEmail(SecurityUtils.getCurrentUserLogin()))
            return connection;
        else
            return null;
    }

    @Transactional
    public Connection save(Connection connection){
        connection.setAuthUser(authUserRepository.findByEmail(SecurityUtils.getCurrentUserLogin()));
        return repository.save(connection);
    }

    @Transactional
    public void delete(Long id){
        repository.deleteById(id);
    }


    @Transactional
    public void update (Connection connection){
        connection.setAuthUser(authUserRepository.findByEmail(SecurityUtils.getCurrentUserLogin()));
        repository.save(connection);
    }
}
