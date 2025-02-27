package com.tee.union.dto.staticdata;

/**
 * Static tables enum
 */
public enum LookupTable {
    ENTITY_TYPE("entity_type", "EntityTypeDto"),
    TICKET_STATUSES("ticket_statuses", "TicketStatusDto"),
    LOG_ACTIONS("log_actions", "LogActionDto"),
    PRIORITIES("priorities", "PriorityDto"),
    ROLES("roles", "RoleDto"),
    USER_STATUSES("user_statuses", "UserStatusDto"),
    ADDRESS_TYPES("address_types", "AddressTypeDto"),
    NOTIFICATION_TYPES("notification_types", "NotificationTypeDto"),
    GENDERS("genders", "GenderDto"),
    MARITAL_STATUSES("marital_statuses", "MaritalStatusDto"),
    PAYMENT_METHODS("payment_methods", "PaymentMethodDto"),
    LOGIN_STATUS("login_status", "LoginStatusDto"),
    PAYMENT_STATUS("payment_status", "PaymentStatusDto"),
    SECTORS("sectors", "SectorDto"),
    OWNERSHIP_TYPE("ownership_type", "OwnershipTypeDto"),
    OTP_TYPES("otp_types", "OtpTypeDto"),
    BLOOD_GROUPS("blood_groups", "BloodGroupDto"),
    LOGIN_TYPES("login_types", "LoginTypeDto"),
    MFA_TYPES("mfa_types", "MfaTypeDto");

    private final String tableName;
    private final String className;

    LookupTable(String tableName, String className) {
        this.tableName = tableName;
        this.className = className;
    }

    public String getTableName() {
        return tableName;
    }

    public String getClassName() {
        return className;
    }

    // Get LookupTable enum by table name (Optional Helper Method)
    public static LookupTable fromTableName(String tableName) {
        for (LookupTable lookup : values()) {
            if (lookup.getTableName().equalsIgnoreCase(tableName)) {
                return lookup;
            }
        }
        throw new IllegalArgumentException("No enum found for table: " + tableName);
    }

    // Get LookupTable enum by class name (Optional Helper Method)
    public static LookupTable fromClassName(String className) {
        for (LookupTable lookup : values()) {
            if (lookup.getClassName().equalsIgnoreCase(className)) {
                return lookup;
            }
        }
        throw new IllegalArgumentException("No enum found for class: " + className);
    }
}