package ru.shipilov.diplom.security.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("user/")
public class UserController {

    @RequestMapping(value = "hello", method = RequestMethod.GET)
    public String returnHello(){
        return "Hello";
    }

}
