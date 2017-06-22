package ru.shipilov.diplom.logic.utils;

import java.util.HashMap;
import java.util.regex.Pattern;

public class PatternGenerator {

    private final static String patternForGUID = "\\w{8}-\\w{4}-\\w{4}-\\w{4}-\\w{12}";

    private static String generateRegexpFrom(String prototype) {
        StringBuilder stringBuilder = new StringBuilder();

        if (prototype.length() > 0){
            char prev = prototype.charAt(0);
            int count = 1;

            for (int i = 1; i < prototype.length(); i++) {
                char c = prototype.charAt(i);

                if (Character.isDigit(c)) {
                    if (count > 0 && Character.isDigit(prev)){
                        count++;
                        prev = c;
                    }
                    if (count > 0 && !Character.isDigit(prev)){
                        stringBuilder.append(Character.isLetter(prev) ? "\\w{" + count + "}" : "\\s{" + count + "}");
                        count = 1;
                        prev = c;
                    }
                    if (count == 0){
                        count++;
                        prev = c;
                    }
                } else if (Character.isLetter(c)) {
                    if (count > 0 && Character.isLetter(prev)){
                        count++;
                        prev = c;
                    }
                    if (count > 0 && !Character.isLetter(prev)){
                        stringBuilder.append(Character.isDigit(prev) ? "\\d{" + count + "}" : "\\s{" + count + "}");
                        count = 1;
                        prev = c;
                    }
                    if (count == 0){
                        count++;
                        prev = c;
                    }
                } else if (Character.isWhitespace(c)) {
                    if (count > 0 && Character.isWhitespace(prev)){
                        count++;
                        prev = c;
                    }
                    if (count > 0 && !Character.isWhitespace(prev)){
                        stringBuilder.append(Character.isDigit(prev) ? "\\d{" + count + "}" : "\\w{" + count + "}");
                        count = 1;
                        prev = c;
                    }
                    if (count == 0){
                        count++;
                        prev = c;
                    }
                } else {
                    if (count > 0){
                        if (Character.isWhitespace(prev)){
                            stringBuilder.append("\\s{" + count + "}");
                        } else {
                            stringBuilder.append(Character.isDigit(prev) ? "\\d{" + count + "}" : "\\w{" + count + "}");
                        }
                    }
                    stringBuilder.append(c);
                    count = 0;
                    prev = c;
                }
            }
            if (count > 0){
                if (Character.isWhitespace(prev)){
                    stringBuilder.append("\\s{" + count + "}");
                } else {
                    stringBuilder.append(Character.isDigit(prev) ? "\\d{" + count + "}" : "\\w{" + count + "}");
                }
            }
        }
        String tryRussian = stringBuilder.toString().replaceAll(Pattern.quote("\\w"), "[а-яА-ЯёЁ]");
        String tryEnglish = stringBuilder.toString().replaceAll(Pattern.quote("\\w"), "[a-zA-Z]");
        String tryBoth = stringBuilder.toString().replaceAll(Pattern.quote("\\w"), "[а-яА-ЯёЁa-zA-Z]");
        if (Pattern.matches(tryEnglish, prototype)){
            return tryEnglish;
        }
        if (Pattern.matches(tryRussian, prototype)){
            return tryRussian;
        }
        if (Pattern.matches(tryBoth, prototype)){
            return tryBoth;
        }

        return stringBuilder.toString();
    }

    public static HashMap<String, Long> getAllRegex(String[] words){
        HashMap<String, Long> countRegex = new HashMap<>();
        String regexp;
        if (Pattern.matches(patternForGUID, words[0])){
            regexp = patternForGUID;
        } else {
            regexp = generateRegexpFrom(words[0]);
        }
        countRegex.put(regexp, 1L);
        for (int i = 1; i < words.length; i++){
            regexp = "";
            if (Pattern.matches(patternForGUID, words[i])){
                regexp = patternForGUID;
                if (countRegex.containsKey(regexp)){
                    countRegex.put(regexp, countRegex.get(regexp) + 1L);
                } else {
                    countRegex.put(regexp, 1L);
                }
            } else {
                //generate firstly
                regexp = generateRegexpFrom(words[i]);
                if (countRegex.containsKey(regexp)){
                    countRegex.put(regexp, countRegex.get(regexp) + 1L);
                } else {
                    countRegex.put(regexp, 1L);
                }
                //check before generate
//                boolean found = false;
//                for (Map.Entry<String, Integer> entry : countRegex.entrySet()){
//                    if (Pattern.matches(entry.getKey(), words[i])){
//                        entry.setValue(entry.getValue() + 1);
//                        found = true;
//                        break;
//                    }
//                }
//                if (!found){
//                    regexp = generateRegexpFrom(words[i]);
//                    countRegex.put(regexp, 1);
//                }
            }
        }
        return countRegex;
    }
}