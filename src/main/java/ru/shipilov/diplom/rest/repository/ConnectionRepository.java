package ru.shipilov.diplom.rest.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.shipilov.diplom.rest.entity.Connection;
import ru.shipilov.diplom.security.entity.AuthUser;

import java.util.List;

@Repository
public interface ConnectionRepository extends JpaRepository<Connection, Long> {

    @Query("select c from Connection c where c.authUser=:user")
    public List<Connection> getAllByAuthUser(@Param("user")AuthUser user);


}
