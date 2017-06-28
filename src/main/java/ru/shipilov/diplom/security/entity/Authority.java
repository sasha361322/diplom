package ru.shipilov.diplom.security.entity;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "authority")
public class Authority {
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "authority_code")
    @Size(min=1, max=50)
    @Enumerated(EnumType.STRING)
    private AuthorityName code;

    @Column(name="description")
    private String description;

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
}