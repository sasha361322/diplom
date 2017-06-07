package ru.shipilov.diplom.logic.utils;

public enum Driver {
    mysql("com.mysql.jdbc.Driver"),
    h2("org.h2.Driver");

    public String getFullName() {
        return fullName;
    }

    Driver(String s){
        this.fullName = s;
    };
    private String fullName;
}
