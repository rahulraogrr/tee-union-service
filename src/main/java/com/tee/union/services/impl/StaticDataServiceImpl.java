package com.tee.union.services.impl;

import com.tee.union.dto.staticdata.BaseLookupDto;
import com.tee.union.mapper.DtoMapper;
import com.tee.union.services.StaticDataService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class StaticDataServiceImpl implements StaticDataService {
    private static final Duration CACHE_TTL = Duration.ofMinutes(10); // Cache expiration time

    private final JdbcTemplate jdbcTemplate;
    private final RedisTemplate<String, Object> redisTemplate;

    public StaticDataServiceImpl(JdbcTemplate jdbcTemplate,
                                 RedisTemplate<String, Object> redisTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.redisTemplate = redisTemplate;
    }

    public <T extends BaseLookupDto> List<T> getLookupValues(String tableName, Class<T> dtoClass) {
        String sql = "SELECT * FROM " + tableName;
        log.info("sql: {}", sql);
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);

        List<T> dtoList = new ArrayList<>();
        for (Map<String, Object> row : rows) {
            T dto = DtoMapper.mapRowToDto(row, dtoClass);
            dtoList.add(dto);
        }
        return dtoList;
    }

    @Override
    public <T extends BaseLookupDto> List<T> getLookupValuesWithCache(String tableName, Class<T> dtoClass) {
        String cacheKey = "lookup::" + tableName;
        log.info("getLookupValuesWithCache: {}", cacheKey);
        List<T> cachedData = (List<T>) redisTemplate.opsForValue().get(cacheKey);
        if (cachedData == null) {
            cachedData = getLookupValues(tableName, dtoClass);
            redisTemplate.opsForValue().set(cacheKey, cachedData, CACHE_TTL); // Cache for 10 minutes
        }
        return cachedData;
    }
}
