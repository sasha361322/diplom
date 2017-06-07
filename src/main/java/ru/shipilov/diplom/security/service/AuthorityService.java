package ru.cinimex.scheduler.security.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.cinimex.scheduler.security.entity.Authority;
import ru.cinimex.scheduler.security.entity.AuthorityName;
import ru.cinimex.scheduler.security.repository.AuthorityRepository;

@Service
public class AuthorityService {
    @Autowired
    AuthorityRepository authorityRepository;

    public Authority create(Authority authority){
        return authorityRepository.save(authority);
    }

    public Authority find(AuthorityName authorityName){
        return authorityRepository.getAuthorityByCode(authorityName);
    }
}
