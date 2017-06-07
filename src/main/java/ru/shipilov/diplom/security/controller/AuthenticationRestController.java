package ru.shipilov.diplom.security.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mobile.device.Device;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import ru.shipilov.diplom.security.JwtAuthenticationRequest;
import ru.shipilov.diplom.security.JwtAuthenticationResponse;
import ru.shipilov.diplom.security.JwtTokenUtil;
import ru.shipilov.diplom.security.JwtUser;
import ru.shipilov.diplom.security.entity.AuthUser;
import ru.shipilov.diplom.security.service.JwtUserDetailsServiceImpl;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("${jwt.route.authentication.auth}")
public class AuthenticationRestController {

    @Value("${jwt.header}")
    private String tokenHeader;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private JwtUserDetailsServiceImpl userDetailsService;

    //Зарегистрироваться
    @RequestMapping(value = "${jwt.route.authentication.sign-up}", method = RequestMethod.POST)
    public ResponseEntity<?> registerAndCreateAuthenticationToken(@RequestBody JwtAuthenticationRequest authenticationRequest, Device device) {
        if (userDetailsService.loadUserByUsername(authenticationRequest.getUsername())!=null){//Если пользователь с таким логином уже существует
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Пользователь с таким логином уже существует");
        }

        userDetailsService.create(new AuthUser(authenticationRequest.getUsername(), authenticationRequest.getPassword()));

//        // Perform the security
//        final Authentication authentication = authenticationManager.authenticate(
//                new UsernamePasswordAuthenticationToken(
//                        authenticationRequest.getUsername(),
//                        authenticationRequest.getPassword()
//                )
//        );
//        SecurityContextHolder.getContext().setAuthentication(authentication);
//        // Reload password post-security so we can generate token
//        final UserDetails userDetails = userDetailsService.loadUserByUsername(authenticationRequest.getUsername());
//        final String token = jwtTokenUtil.generateToken(userDetails, device);
//
//        // Return the token
        return ResponseEntity.ok("Вы успешно зарегистрированы");
    }

    //Войти
    @RequestMapping(value = "${jwt.route.authentication.sign-in}", method = RequestMethod.POST)
    public ResponseEntity<?> createAuthenticationToken(@RequestBody JwtAuthenticationRequest authenticationRequest, Device device) throws AuthenticationException {

        // Perform the security
        final Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        authenticationRequest.getUsername(),
                        authenticationRequest.getPassword()
                )
        );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        // Reload password post-security so we can generate token
        UserDetails userDetails = userDetailsService.loadUserByUsername(authenticationRequest.getUsername());
        final String token = jwtTokenUtil.generateToken(userDetails, device);

        // Return the token
        return ResponseEntity.ok(new JwtAuthenticationResponse(token));
    }

    //Выйти
    @RequestMapping(value = "${jwt.route.authentication.logout}", method = RequestMethod.POST)
    public ResponseEntity<?> logout() throws AuthenticationException {

        SecurityContextHolder.clearContext();
        return ResponseEntity.ok("Вы не в системе");
    }



    @RequestMapping(value = "${jwt.route.authentication.refresh}", method = RequestMethod.GET)
    public ResponseEntity<?> refreshAndGetAuthenticationToken(HttpServletRequest request) {
        String token = request.getHeader(tokenHeader);
        String username = jwtTokenUtil.getUsernameFromToken(token);
        JwtUser user = (JwtUser) userDetailsService.loadUserByUsername(username);

        if (jwtTokenUtil.canTokenBeRefreshed(token, user.getLastPasswordResetDate())) {
            String refreshedToken = jwtTokenUtil.refreshToken(token);
            return ResponseEntity.ok(new JwtAuthenticationResponse(refreshedToken));
        } else {
            return ResponseEntity.badRequest().body(null);
        }
    }

}
