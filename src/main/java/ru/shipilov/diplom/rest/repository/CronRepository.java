package ru.cinimex.scheduler.rest.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.cinimex.scheduler.rest.entity.Cron;

@Repository
public interface CronRepository extends JpaRepository<Cron, Long> {

}
