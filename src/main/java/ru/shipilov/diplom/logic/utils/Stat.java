package ru.shipilov.diplom.logic.utils;

public class Stat{
    public static int Sturges(Long count){
        return (int)(1+3.322*Math.log(count));
    }
}
