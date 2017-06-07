package ru.shipilov.diplom.security.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.shipilov.diplom.security.JwtUserFactory;
import ru.shipilov.diplom.security.entity.AuthUser;
import ru.shipilov.diplom.security.entity.Authority;
import ru.shipilov.diplom.security.entity.AuthorityName;
import ru.shipilov.diplom.security.repository.AuthUserRepository;
import ru.shipilov.diplom.security.repository.AuthorityRepository;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

@Service
public class JwtUserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private AuthUserRepository authUserRepository;

    @Autowired
    private AuthorityRepository authorityRepository;

    private static final AuthorityName USER = AuthorityName.ROLE_USER;

    @Override
    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        AuthUser authUser = authUserRepository.findByEmail(username);
        if (authUser == null) {
//            throw new UsernameNotFoundException("No user found");
            return null;
        } else {
            return JwtUserFactory.create(authUser);
        }
    }

    @Transactional
    public AuthUser create(AuthUser authUser){
        if (authUser.getAuthorities()==null){
            Set<Authority> authorities = new HashSet<Authority>(Arrays.asList(authorityRepository.getAuthorityByCode(USER)));
            authUser.setAuthorities(authorities);
            authUser.setPassword(new BCryptPasswordEncoder().encode(authUser.getPassword()));
        }
        return authUserRepository.save(authUser);
    }
}