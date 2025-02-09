package com.tee.union.services.impl;

import com.tee.union.dto.staticdata.BaseLookupDto;
import com.tee.union.dto.staticdata.LookupTable;
import com.tee.union.mapper.DtoMapper;
import com.tee.union.services.StaticDataService;
import com.tee.union.utils.LookupUtil;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.*;

@Slf4j
@Service
public class StaticDataServiceImpl implements StaticDataService {
    private static final Duration CACHE_TTL = Duration.ofMinutes(30); // Cache expiration time

    private final JdbcTemplate jdbcTemplate;
    private final LookupUtil lookupUtil;
    private final RedisTemplate<String, Object> redisTemplate;

    public StaticDataServiceImpl(JdbcTemplate jdbcTemplate,
                                 LookupUtil lookupUtil,
                                 RedisTemplate<String, Object> redisTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.lookupUtil = lookupUtil;
        this.redisTemplate = redisTemplate;
    }

    @PostConstruct
    public void preloadLookupData() {
        log.info("Preloading lookup tables into cache...");

        // Delete existing cache entries before preloading fresh data
        EnumSet.allOf(LookupTable.class).forEach(lookupTable -> {
            String cacheKey = "lookup::" + lookupTable.getTableName();
            redisTemplate.delete(cacheKey);  // Deletes the existing cache key
            getLookupValuesWithCache(lookupTable.getTableName(), lookupUtil.getDtoClass(lookupTable)); //load fresh data
        });

        log.info("Lookup tables preloaded successfully.");
    }

    public <T extends BaseLookupDto> List<T> getLookupValues(String tableName, Class<T> dtoClass) {
        if (Arrays.stream(LookupTable.values()).noneMatch(t -> t.getTableName().equals(tableName))) {
            throw new IllegalArgumentException("Invalid table name: " + tableName);
        }

        String sql = "SELECT * FROM " + tableName;
        log.info("Executing SQL: {}", sql);

        try {
            List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
            List<T> dtoList = new ArrayList<>();
            for (Map<String, Object> row : rows) {
                T dto = DtoMapper.mapRowToDto(row, dtoClass);
                dtoList.add(dto);
            }
            return dtoList;
        } catch (Exception e) {
            log.error("Error fetching data for table {}: {}", tableName, e.getMessage());
            return Collections.emptyList();
        }
    }

    @Override
    public <T extends BaseLookupDto> List<T> getLookupValuesWithCache(String tableName, Class<T> dtoClass) {
        String cacheKey = "lookup::" + tableName;
        log.info("Fetching lookup data from cache: {}", cacheKey);

        List<T> cachedData = (List<T>) redisTemplate.opsForValue().get(cacheKey);
        if (cachedData == null) {
            log.info("Cache miss for table: {}, querying DB...", tableName);
            cachedData = getLookupValues(tableName, dtoClass);
            redisTemplate.opsForValue().set(cacheKey, cachedData, CACHE_TTL);
        } else {
            log.info("Cache hit for table: {}", tableName);
        }
        return cachedData;
    }
}