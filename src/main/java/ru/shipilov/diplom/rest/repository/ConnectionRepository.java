package ru.shipilov.diplom.rest.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.shipilov.diplom.rest.entity.Connection;

@Repository
public interface ConnectionRepository extends JpaRepository<Connection, Long> {

}
