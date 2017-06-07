package ru.shipilov.diplom.security.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.shipilov.diplom.security.entity.Authority;
import ru.shipilov.diplom.security.entity.AuthorityName;
import ru.shipilov.diplom.security.repository.AuthorityRepository;

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
