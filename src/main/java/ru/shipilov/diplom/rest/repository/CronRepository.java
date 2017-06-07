package ru.shipilov.diplom.rest.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.shipilov.diplom.rest.entity.Cron;

@Repository
public interface CronRepository extends JpaRepository<Cron, Long> {

}
