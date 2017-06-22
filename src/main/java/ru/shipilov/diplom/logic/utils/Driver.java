package ru.shipilov.diplom.logic.utils;

public enum Driver {
    MYSQL("com.mysql.jdbc.Driver"),
    H2("org.h2.Driver");


    public String getFullName() {
        return fullName;
    }

    Driver(String s){
        this.fullName = s;
    };
    private String fullName;
}
