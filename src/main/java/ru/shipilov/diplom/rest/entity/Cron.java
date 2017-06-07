package ru.shipilov.diplom.rest.entity;

import ru.shipilov.diplom.security.entity.AuthUser;

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

@Entity
@Table(name = "cron")
public class Cron {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "cron_id")
    private Long id;

    @Column(name = "cron")
    private String cron;

    @Column(name = "description")
    private String description;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="authUser", referencedColumnName="auth_user_id")
    private AuthUser authUser;

    public AuthUser getAuthUser() {
        return authUser;
    }

    public void setAuthUser(AuthUser authUser) {
        this.authUser = authUser;
    }

    public String getCron() {
        return cron;
    }

    public void setCron(String cron) {
        this.cron = cron;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}