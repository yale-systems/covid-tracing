package org.yale.registry.research.utilities;

import java.util.*;

public class EnumMapUtility {
    public static Map<String, Map<String, Integer>> generateEnumMap(List<Class> enumClasses){
        Map<String, Map<String, Integer>> enumMap = new HashMap<>();
        for(Class<Enum> enumClass: enumClasses){
            String enumName = enumClass.getName();
            Map<String, Integer> singleEnumMap = new HashMap<>();
            List<Enum> values = new ArrayList<>(EnumSet.allOf(enumClass));
            List<String> stringValues = new ArrayList<>();
            for(Enum value: values){
                stringValues.add(value.name());
            }
            for(String stringValue: stringValues){
                String subString = stringValue.substring(stringValue.lastIndexOf('$') + 1);
                singleEnumMap.put(subString, Enum.valueOf(enumClass, stringValue).ordinal());
            }
            String enumSubstring = enumName.substring(enumName.lastIndexOf('$') + 1);
            enumMap.put(enumSubstring, singleEnumMap);
        }
        return enumMap;
    }
}
