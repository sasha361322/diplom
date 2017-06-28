package ru.shipilov.diplom.logic.utils;

public class MyCryptActionListener implements XImgCrypto.CryptActionListener {

    @Override
    public byte[] PrivateKeyRequired() {
        return "MySuperSecretKey".getBytes();
    }
}
