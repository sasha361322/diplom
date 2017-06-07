package ru.cinimex.scheduler.security.entity;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Set;

@Entity
@Table(name = "authority")
public class Authority {
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "code")
    @Size(min=1, max=50)
    @Enumerated(EnumType.STRING)
//    private String code;
    private AuthorityName code;

    @Column(name="description")
    private String description;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "user_authority",
            joinColumns = @JoinColumn(name = "auth_user"),
            inverseJoinColumns = @JoinColumn(name = "authority"))
    private Set<AuthUser> authUsers;


    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public AuthorityName getCode() {
        return code;
    }

    public void setCode(AuthorityName code) {
        this.code = code;
    }

    public Set<AuthUser> getAuthUsers() {
        return authUsers;
    }

    public void setAuthUsers(Set<AuthUser> authUsers) {
        this.authUsers = authUsers;
    }
}