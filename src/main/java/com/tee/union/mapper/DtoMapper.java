package com.tee.union.mapper;

import com.tee.union.dto.staticdata.BaseLookupDto;
import lombok.extern.slf4j.Slf4j;

import java.lang.reflect.Field;
import java.util.Map;

@Slf4j
public class DtoMapper {
    public static <T extends BaseLookupDto> T mapRowToDto(Map<String, Object> row, Class<T> dtoClass) {
        try {
            T dto = dtoClass.getDeclaredConstructor().newInstance();
            for (Map.Entry<String, Object> entry : row.entrySet()) {
                String fieldName = entry.getKey();
                Object value = entry.getValue();
                Field field = findField(dtoClass, fieldName);
                if (field != null) {
                    field.setAccessible(true);
                    field.set(dto, value);
                }
            }
            return dto;
        } catch (Exception e) {
            throw new RuntimeException("Error mapping row to DTO", e);
        }
    }

    private static Field findField(Class<?> clazz, String fieldName) {
        try {
            return clazz.getDeclaredField(fieldName);
        } catch (NoSuchFieldException e) {
            if (clazz.getSuperclass() != null) {
                return findField(clazz.getSuperclass(), fieldName); // Recursively check parent classes
            }
            return null;
        }
    }
}
