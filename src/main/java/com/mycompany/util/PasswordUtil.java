package com.mycompany.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.nio.charset.StandardCharsets;

public class PasswordUtil {

    private static final String ALGORITHM = "SHA-256";

    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance(ALGORITHM);
            byte[] hashedBytes = md.digest(password.getBytes(StandardCharsets.UTF_8));
            return Base64.getEncoder().encodeToString(hashedBytes);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    // ✅ SUPPORT OLD + NEW USERS
    public static boolean verifyPassword(String plainPassword, String storedPassword) {

        // OLD USER (PLAINTEXT)
        if (storedPassword.length() < 40) {
            return plainPassword.equals(storedPassword);
        }

        // NEW USER (HASHED)
        return hashPassword(plainPassword).equals(storedPassword);
    }

    public static boolean isPlainText(String password) {
        return password.length() < 40;
    }
}
