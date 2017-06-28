package ru.shipilov.diplom.rest.entity;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.codec.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.security.Key;

@Converter
public class JPACryptoConverter implements AttributeConverter<String, String> {

    static Logger logger = LoggerFactory.getLogger(JPACryptoConverter.class);

    private static String ALGORITHM = "AES/ECB/PKCS5Padding";
    private static byte[] KEY = "MySuperSecretKey".getBytes();

    @Override
    public String convertToDatabaseColumn(String sensitive) {
        Key key = new SecretKeySpec(KEY, "AES");
        try {
            final Cipher c = Cipher.getInstance(ALGORITHM);
            c.init(Cipher.ENCRYPT_MODE, key);
            final String encrypted = new String(Base64.encode(c
                    .doFinal(sensitive.getBytes())), "UTF-8");
            return encrypted;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public String convertToEntityAttribute(String sensitive) {
        Key key = new SecretKeySpec(KEY, "AES");
        try {
            final Cipher c = Cipher.getInstance(ALGORITHM);
            c.init(Cipher.DECRYPT_MODE, key);
            final String decrypted = new String(c.doFinal(Base64
                    .decode(sensitive.getBytes("UTF-8"))));
            return decrypted;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}