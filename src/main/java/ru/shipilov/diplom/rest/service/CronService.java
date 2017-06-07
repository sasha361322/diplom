package ru.shipilov.diplom.rest.service;

import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.shipilov.diplom.rest.entity.Cron;
import ru.shipilov.diplom.rest.repository.CronRepository;

import javax.transaction.Transactional;
import java.util.List;


@Service
public class CronService {

    @Autowired
    private CronRepository cronRepository;

    @Transactional
    public Cron getById(long id){
        return cronRepository.getOne(id);
    }

    @Transactional
    public List<Cron> getAll(){
        return Lists.newArrayList(cronRepository.findAll());
    }

    @Transactional
    public Cron save(Cron cron){
        return cronRepository.save(cron);
    }

    @Transactional
    public List <Cron> save(List<Cron> crons){
        for (Cron cron : crons){
            save(cron);
        }
        return crons;
    }

    @Transactional
    public void delete(Long id){
        cronRepository.deleteById(id);
    }

    @Transactional
    public void update (List<Cron> crons){
        for (Cron p : crons)
            cronRepository.save(p);
    }
}
