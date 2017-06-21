package ru.shipilov.diplom.security.entity;


import ru.shipilov.diplom.rest.entity.Connection;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Date;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "auth_user")
public class AuthUser {

    @Id
    @Column(name = "auth_user_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    @SequenceGenerator(name = "user_seq", sequenceName = "user_seq", allocationSize = 1)
    private Long id;

    @Column(name = "email", length = 256, unique = true)
    @NotNull
    @Size(min = 4, max = 50)
    private String email;

    @Column(name = "first_name", length = 256)
    @Size(min = 4, max = 256)
    private String firstname;

    @Column(name = "last_name", length = 256)
    @Size(min = 4, max = 256)
    private String lastname;

    @Column(name = "password", length = 256)
    @NotNull
    @Size(min = 4, max = 256)
    private String password;

    @Column(name = "active")
    private Boolean active;

    @Column(name = "last_password_reset_date")
    @Temporal(TemporalType.TIMESTAMP)
    @NotNull
    private Date lastPasswordResetDate;

    @ManyToMany(fetch = FetchType.EAGER, mappedBy = "authUsers")
    private Set<Authority> authorities;

    @OneToMany(mappedBy = "authUser", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Connection> connections;

    public AuthUser(String email, String password) {
        this.email = email;
        this.password = password;
        this.lastPasswordResetDate = new Date();
        this.active = true;
    }

    public AuthUser() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Set<Authority> getAuthorities() {
        return authorities;
    }

    public void setAuthorities(Set<Authority> authorities) {
        this.authorities = authorities;
    }

    public Date getLastPasswordResetDate() {
        return lastPasswordResetDate;
    }

    public void setLastPasswordResetDate(Date lastPasswordResetDate) {
        this.lastPasswordResetDate = lastPasswordResetDate;
    }

    public List<Connection> getConnections() {
        return connections;
    }

    public void setConnections(List<Connection> connections) {
        this.connections = connections;
    }
}