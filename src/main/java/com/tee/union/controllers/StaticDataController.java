package com.tee.union.controllers;

import com.tee.union.dto.staticdata.BaseLookupDto;
import com.tee.union.dto.staticdata.LookupTable;
import com.tee.union.services.StaticDataService;
import com.tee.union.utils.LookupUtil;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/v1/static")
@Tag(name = "staticData", description = "StaticDataController")
public class StaticDataController {
    private final StaticDataService staticDataService;
    private final LookupUtil lookupUtil;

    public StaticDataController(StaticDataService staticDataService, LookupUtil lookupUtil) {
        this.staticDataService = staticDataService;
        this.lookupUtil = lookupUtil;
    }

    @GetMapping("/{tableName}")
    public ResponseEntity<?> getLookupData(@PathVariable String tableName) {
        try {
            LookupTable lookupTable = LookupTable.fromTableName(tableName);
            Class<? extends BaseLookupDto> dtoClass = lookupUtil.getDtoClass(lookupTable);

            List<? extends BaseLookupDto> lookupData = staticDataService.getLookupValuesWithCache(tableName, dtoClass);
            return ResponseEntity.ok(lookupData);

        } catch (IllegalArgumentException e) {
            return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .body("Invalid table name: " + tableName);
        } catch (Exception e) {
            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An error occurred while fetching lookup data.");
        }
    }

}
