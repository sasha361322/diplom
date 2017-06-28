package ru.shipilov.diplom.rest.entity;

import org.apache.commons.codec.binary.Base64;
import ru.shipilov.diplom.logic.utils.MyCryptActionListener;
import ru.shipilov.diplom.logic.utils.XImgCrypto;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.io.UnsupportedEncodingException;

@Converter
public class JPACryptoConverter implements AttributeConverter<String, String> {
    private static XImgCrypto xImgCrypto;
    static{
        xImgCrypto = new XImgCrypto(new MyCryptActionListener());
        try {
            xImgCrypto.init("src/main/resources");//C:\Users\sasha\Desktop\diplom\src\main\resources
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String convertToDatabaseColumn(String s) {
        try {
            return new String(xImgCrypto.crypt(Base64.encodeBase64(s.getBytes("UTF-8"))));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public String convertToEntityAttribute(String s) {
        try {
            return new String(xImgCrypto.decrypt(Base64.decodeBase64(s.getBytes("UTF-8"))));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        }
    }

/*
    public static void main(String[] args) {
        try {
//            System.out.println(new String(xImgCrypto.decrypt(xImgCrypto.crypt("".getBytes("UTF-8")))));
//            String res = new String(org.apache.commons.codec.binary.Base64.encodeBase64(
//                    xImgCrypto.crypt("".getBytes("UTF-8"))));
//            System.out.println(res);
            String res = new String(xImgCrypto.decrypt(org.apache.commons.codec.binary.Base64.decodeBase64("JBuLuD4hhcsJqiBg5Mlfyg==" .getBytes("UTF-8"))));
            System.out.println(res+res.length());

        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }
    */
}