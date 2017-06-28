package ru.shipilov.diplom.rest.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import ru.shipilov.diplom.logic.utils.Driver;
import ru.shipilov.diplom.security.entity.AuthUser;

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

@Entity
@Table(name = "connection")
public class Connection {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "connection_id")
    private Long id;

    @Column(name = "url")
    private String url;

    @Column(name = "driver")
    @Enumerated(EnumType.STRING)
    private Driver driver;

    @Column(name="user")
    private String user;

    @Column(name="password", columnDefinition = "CLOB")
    @Convert(converter = JPACryptoConverter.class)
    private String password;

    @Column(name="schema")
    private String schema;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="authUser", referencedColumnName="auth_user_id")
    @JsonIgnore
    private AuthUser authUser;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Driver getDriver() {
        return driver;
    }

    public void setDriver(Driver driver) {
        this.driver = driver;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSchema() {
        return schema;
    }

    public void setSchema(String schema) {
        this.schema = schema;
    }

    public AuthUser getAuthUser() {
        return authUser;
    }

    public void setAuthUser(AuthUser authUser) {
        this.authUser = authUser;
    }
}