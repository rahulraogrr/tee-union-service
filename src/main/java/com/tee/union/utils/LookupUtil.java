package com.tee.union.utils;

import com.tee.union.dto.staticdata.*;
import jakarta.annotation.PostConstruct;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class LookupUtil {
    private final Map<LookupTable, Class<? extends BaseLookupDto>> lookupMap = new HashMap<>();

    @PostConstruct
    private void init() {
        lookupMap.put(LookupTable.ENTITY_TYPE, EntityTypeDto.class);
        lookupMap.put(LookupTable.TICKET_STATUSES, TicketStatusDto.class);
        lookupMap.put(LookupTable.LOG_ACTIONS, LogActionDto.class);
        lookupMap.put(LookupTable.PRIORITIES, PriorityDto.class);
        lookupMap.put(LookupTable.ROLES, RoleDto.class);
        lookupMap.put(LookupTable.USER_STATUSES, UserStatusDto.class);
        lookupMap.put(LookupTable.ADDRESS_TYPES, AddressTypeDto.class);
        lookupMap.put(LookupTable.NOTIFICATION_TYPES, NotificationTypeDto.class);
        lookupMap.put(LookupTable.GENDERS, GenderDto.class);
        lookupMap.put(LookupTable.MARITAL_STATUSES, MaritalStatusDto.class);
        lookupMap.put(LookupTable.PAYMENT_METHODS, PaymentMethodDto.class);
        lookupMap.put(LookupTable.LOGIN_STATUS, LoginStatusDto.class);
        lookupMap.put(LookupTable.PAYMENT_STATUS, PaymentStatusDto.class);
    }

    public Class<? extends BaseLookupDto> getDtoClass(LookupTable lookupTable) {
        Class<? extends BaseLookupDto> dtoClass = lookupMap.get(lookupTable);
        if (dtoClass == null) {
            throw new IllegalArgumentException("No matching DTO class for: " + lookupTable);
        }
        return dtoClass;
    }
}
