package com.tee.union.services;

import com.tee.union.dto.staticdata.BaseLookupDto;
import java.util.List;

public interface StaticDataService {
    <T extends BaseLookupDto> List<T> getLookupValuesWithCache(String tableName, Class<T> dtoClass);
}