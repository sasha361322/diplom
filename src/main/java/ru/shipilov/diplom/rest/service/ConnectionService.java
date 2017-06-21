package ru.shipilov.diplom.rest.service;

import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.shipilov.diplom.rest.entity.Connection;
import ru.shipilov.diplom.rest.repository.ConnectionRepository;
import ru.shipilov.diplom.security.entity.AuthUser;

import javax.transaction.Transactional;
import java.util.List;


@Service
public class ConnectionService {

    @Autowired
    private ConnectionRepository connectionRepository;

    @Transactional
    public Connection getById(long id){
        return connectionRepository.getOne(id);
    }

    @Transactional
    public List<Connection> getAll(){
        return Lists.newArrayList(connectionRepository.findAll());
    }

    @Transactional
    public Connection save(Connection cron){
        return connectionRepository.save(cron);
    }

    @Transactional
    public List <Connection> save(List<Connection> crons){
        for (Connection cron : crons){
            save(cron);
        }
        return crons;
    }

    @Transactional
    public void delete(Long id){
        connectionRepository.deleteById(id);
    }

    @Transactional
    public List<Connection> getAllForUser(AuthUser user){
        return connectionRepository.getAllByAuthUser(user);
    }

    @Transactional
    public void update (List<Connection> crons){
        for (Connection p : crons)
            connectionRepository.save(p);
    }
}
