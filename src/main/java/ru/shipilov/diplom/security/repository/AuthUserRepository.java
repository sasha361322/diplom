package ru.shipilov.diplom.security.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import ru.shipilov.diplom.security.entity.AuthUser;

import java.util.Set;

public interface AuthUserRepository extends JpaRepository<AuthUser, Long> {

    @Query("select u from AuthUser u where u.email=:email")
    AuthUser findByEmail(@Param("email") String email);

    @Query("select u from AuthUser u where u.email=:email")
    Set<AuthUser> test(@Param("email") String email);
}