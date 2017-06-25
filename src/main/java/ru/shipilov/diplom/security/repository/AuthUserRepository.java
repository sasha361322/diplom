package ru.shipilov.diplom.security.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.shipilov.diplom.security.entity.AuthUser;

@Repository
public interface AuthUserRepository extends JpaRepository<AuthUser, Long> {

    @Query("select u from AuthUser u where u.email=:email")
    AuthUser findByEmail(@Param("email") String email);

}