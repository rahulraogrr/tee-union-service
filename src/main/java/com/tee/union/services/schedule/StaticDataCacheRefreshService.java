package com.tee.union.services.schedule;

import com.tee.union.dto.staticdata.LookupTable;
import com.tee.union.services.StaticDataService;
import com.tee.union.utils.LookupUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.EnumSet;

@Slf4j
@Service
public class StaticDataCacheRefreshService {
    private final RedisTemplate<String, Object> redisTemplate;
    private final StaticDataService staticDataService;
    private final LookupUtil lookupUtil;

    public StaticDataCacheRefreshService(RedisTemplate<String, Object> redisTemplate,
                                         StaticDataService staticDataService,
                                         LookupUtil lookupUtil) {
        this.redisTemplate = redisTemplate;
        this.staticDataService = staticDataService;
        this.lookupUtil = lookupUtil;
    }

    /**
     * 	•	0 – Second: The task will trigger at the 0th second of each minute.
     * 	•	0/30 – Minute: This means the task will run every 30 minutes starting from minute 0.
     * 	•	* – Hour: The task will run every hour.
     * 	•	* – Day of the month: The task will run every day.
     * 	•	* – Month: The task will run every month.
     * 	•	? – Day of the week: The ? means no specific day of the week (since we are specifying the day of the month).
     * 	    (cron = "0 0 * * * ?")  // Cron expression to run every hour
     *      (cron = "0 0/5 * * * ?")
     */
    @Scheduled(cron = "0 0/30 * * * ?") // Runs every 30 minutes
    public void refreshCacheHourly() {
        log.info("Refreshing lookup tables cache...");

        // Loop through all lookup tables and refresh their cache
        EnumSet.allOf(LookupTable.class).forEach(lookupTable -> {
            String cacheKey = "lookup::" + lookupTable.getTableName();

            // Delete the existing cache for the table
            redisTemplate.delete(cacheKey);
            log.info("Deleted cache for table: {}", lookupTable.getTableName());

            // Reload fresh data and set it into cache
            staticDataService.getLookupValuesWithCache(lookupTable.getTableName(),
                    lookupUtil.getDtoClass(lookupTable));
            log.info("Refreshed cache for table: {}", lookupTable.getTableName());
        });

        log.info("Lookup tables cache refreshed successfully.");
    }

}
