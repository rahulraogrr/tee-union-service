CREATE SCHEMA IF NOT EXISTS teeunion;

-- Cleanup existing tables (if needed)
DROP TABLE IF EXISTS ticket_logs CASCADE;
DROP TABLE IF EXISTS tickets CASCADE;
DROP TABLE IF EXISTS escalation_levels CASCADE;
DROP TABLE IF EXISTS addresses CASCADE;
DROP TABLE IF EXISTS events CASCADE;
DROP TABLE IF EXISTS event_types CASCADE;
DROP TABLE IF EXISTS members CASCADE;
DROP TABLE IF EXISTS member_roles CASCADE;
DROP TABLE IF EXISTS genders CASCADE;
DROP TABLE IF EXISTS marital_statuses CASCADE;
DROP TABLE IF EXISTS roles CASCADE;
DROP TABLE IF EXISTS priorities CASCADE;
DROP TABLE IF EXISTS log_actions CASCADE;
DROP TABLE IF EXISTS ticket_statuses CASCADE;
DROP TABLE IF EXISTS user_statuses CASCADE;
DROP TABLE IF EXISTS address_types CASCADE;
DROP TABLE IF EXISTS external_logins CASCADE;
DROP TABLE IF EXISTS user_tokens CASCADE;
DROP TABLE IF EXISTS user_otp CASCADE;
DROP TABLE IF EXISTS regions CASCADE;
DROP TABLE IF EXISTS political_status CASCADE;
DROP TABLE IF EXISTS countries CASCADE;
DROP TABLE IF EXISTS states CASCADE;
DROP TABLE IF EXISTS districts CASCADE;
DROP TABLE IF EXISTS cities CASCADE;
DROP TABLE IF EXISTS priority_escalation_mapping CASCADE;
DROP TABLE IF EXISTS audit_logs CASCADE;
DROP TABLE IF EXISTS biometric_data CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS payment_methods CASCADE;
DROP TABLE IF EXISTS notifications CASCADE;
DROP TABLE IF EXISTS notification_types CASCADE;
DROP TABLE IF EXISTS unions CASCADE;
DROP TABLE IF EXISTS organisations CASCADE;
DROP TABLE IF EXISTS entity_type CASCADE;
DROP TABLE IF EXISTS login_status CASCADE;
DROP TABLE IF EXISTS logins CASCADE;
DROP TABLE IF EXISTS payment_status CASCADE;
DROP TABLE IF EXISTS member_role_history CASCADE;
DROP TABLE IF EXISTS companies CASCADE;
DROP TABLE IF EXISTS sectors CASCADE;
DROP TABLE IF EXISTS ownership_type CASCADE;
DROP TABLE IF EXISTS otp_types CASCADE;
DROP TABLE IF EXISTS member_otp CASCADE;
DROP TABLE IF EXISTS blood_groups CASCADE;
DROP TABLE IF EXISTS databasechangelog CASCADE;
DROP TABLE IF EXISTS databasechangeloglock CASCADE;

-- Entity Type Table
CREATE TABLE entity_type
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN ('MEMBER', 'ORGANISATION', 'UNION', 'COMPANY')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

-- Ticket Statuses Table
CREATE TABLE ticket_statuses
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN ('OPEN', 'IN_PROGRESS', 'ESCALATED', 'CLOSED')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

-- Log Actions Table
CREATE TABLE log_actions
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN ('STATUS_CHANGE', 'ESCALATION', 'COMMENT')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

-- Priorities Table
CREATE TABLE priorities
(
    id           SMALLSERIAL PRIMARY KEY,
    name         VARCHAR(50) NOT NULL UNIQUE CHECK (name IN ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL')),
    description  TEXT,
    sla_duration INTERVAL    NOT NULL,
    weight       SMALLINT    NOT NULL DEFAULT 1,
    created_at   TIMESTAMP            DEFAULT NOW(),
    updated_at   TIMESTAMP            DEFAULT NOW()
);

-- Event Types Table
CREATE TABLE event_types
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

-- User Statuses Table
CREATE TABLE user_statuses
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN ('ACTIVE', 'INACTIVE', 'RETIRED')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

CREATE TABLE payment_status
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN ('PENDING', 'COMPLETED', 'FAILED', 'UNKNOWN')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);


-- Address Types Table
CREATE TABLE address_types
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

-- Notification Types Table
CREATE TABLE notification_types
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN ('EVENT_UPDATE', 'ANNOUNCEMENT', 'EMERGENCY')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

-- Genders Table
CREATE TABLE genders
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN ('MALE', 'FEMALE', 'OTHER')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

-- Marital Statuses Table
CREATE TABLE marital_statuses
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN ('SINGLE', 'MARRIED', 'DIVORCED', 'WIDOWED', 'SEPARATED')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

-- Payment Methods Table
CREATE TABLE payment_methods
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN
                                                   ('CREDIT_CARD', 'DEBIT_CARD', 'PAYPAL', 'BANK_TRANSFER', 'APPLE_PAY',
                                                    'GOOGLE_PAY')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

-- Roles Table
CREATE TABLE roles
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE, -- REGISTER, ADMIN, MANAGER, USER, IT, SUPER_USER
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

-- Login Status Table
CREATE TABLE login_status
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN
                                                   ('SUCCESS', 'FAILED', 'LOCKED', 'EXPIRED', 'INACTIVE', 'PENDING',
                                                    'BANNED', 'DISCONNECTED', 'TIMED_OUT', 'VERIFICATION_REQUIRED')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

CREATE TABLE sectors
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN
                                                   ('GENERATION', 'TRANSMISSION', 'DISTRIBUTION')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

CREATE TABLE ownership_type
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN
                                                   ('GOVERNMENT', 'PRIVATE', 'PUBLIC-PRIVATE')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

CREATE TABLE otp_types
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN
                                                   ('EMAIL', 'SMS')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

CREATE TABLE blood_groups
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN
                                                   ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-','BOMBAY', 'RH-NULL')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

-- Organisations Table
CREATE TABLE organisations
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

CREATE TABLE companies
(
    id               SMALLSERIAL PRIMARY KEY,
    organisation_id  SMALLINT NOT NULL REFERENCES organisations (id) ON DELETE CASCADE,
    name             VARCHAR(100) NOT NULL UNIQUE,
    sector_id        SMALLINT     NOT NULL REFERENCES sectors (id),
    ownership_id     SMALLINT     NOT NULL REFERENCES ownership_type (id),
    headquarters     VARCHAR(100),
    established_date DATE,
    created_at       TIMESTAMP DEFAULT NOW(),
    updated_at       TIMESTAMP DEFAULT NOW(),
    CONSTRAINT unique_company_per_organisation UNIQUE (name, organisation_id)
);

-- Unions Table
CREATE TABLE unions
(
    id              SMALLSERIAL PRIMARY KEY,
    company_id      SMALLINT NOT NULL REFERENCES companies (id) ON DELETE CASCADE,
    name            VARCHAR(255) NOT NULL,
    description     TEXT,
    created_at      TIMESTAMP DEFAULT NOW(),
    updated_at      TIMESTAMP DEFAULT NOW(),
    CONSTRAINT unique_union_per_company UNIQUE (name, company_id)
);

-- Political Status Table
CREATE TABLE political_status
(
    id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name       VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);

-- Regions Table
CREATE TABLE regions
(
    id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name       VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);

-- Countries Table
CREATE TABLE countries
(
    id             BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name           VARCHAR(100) NOT NULL UNIQUE,
    iso_alpha2     CHAR(2)      NOT NULL UNIQUE,
    iso_alpha3     CHAR(3)      NOT NULL UNIQUE,
    telephone_code VARCHAR(10)  NOT NULL,
    lcy            CHAR(3)      NOT NULL,
    region_id      BIGINT       NOT NULL REFERENCES regions (id) ON DELETE CASCADE,
    status_id      BIGINT       NOT NULL REFERENCES political_status (id) ON DELETE RESTRICT,
    created_at     TIMESTAMP DEFAULT now(),
    updated_at     TIMESTAMP DEFAULT now(),
    CONSTRAINT unique_iso_alpha2 UNIQUE (iso_alpha2),
    CONSTRAINT unique_iso_alpha3 UNIQUE (iso_alpha3)
);

-- States Table
CREATE TABLE states
(
    id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    code       VARCHAR(10),
    country_id BIGINT       NOT NULL REFERENCES countries (id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now(),
    CONSTRAINT unique_state_per_country UNIQUE (name, country_id),
    CONSTRAINT unique_state_code UNIQUE (code)
);

-- Districts Table
CREATE TABLE districts
(
    id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    state_id   BIGINT       NOT NULL REFERENCES states (id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now(),
    CONSTRAINT unique_district_per_state UNIQUE (name, state_id),
    CONSTRAINT unique_district_name UNIQUE (name)
);

-- Cities Table
CREATE TABLE cities
(
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    district_id BIGINT       NOT NULL REFERENCES districts (id) ON DELETE CASCADE,
    created_at  TIMESTAMP DEFAULT now(),
    updated_at  TIMESTAMP DEFAULT now(),
    CONSTRAINT unique_city_per_county UNIQUE (name, district_id)
);

-- Addresses Table
CREATE TABLE addresses
(
    id            BIGSERIAL PRIMARY KEY,
    entity_id     SMALLINT NOT NULL REFERENCES entity_type (id), -- ID of the related entity (member, company , organisation, or union)
    house_no      VARCHAR(255),
    building_name VARCHAR(255),
    street        VARCHAR(255) NOT NULL,
    locality      VARCHAR(255),
    landmark      VARCHAR(255),
    postal_code   VARCHAR(20),
    city_id       BIGINT       NOT NULL REFERENCES cities (id),        -- Reference to a city
    type_id       SMALLINT     NOT NULL REFERENCES address_types (id), -- Address type (HOME, WORK, etc.)
    created_at    TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- Members Table
CREATE TABLE members
(
    id                        BIGSERIAL PRIMARY KEY,
    union_id                  SMALLINT REFERENCES unions (id) ON DELETE SET NULL,
    first_name                VARCHAR(255) NOT NULL,
    middle_name               VARCHAR(255),
    last_name                 VARCHAR(255) NOT NULL,
    phone                     VARCHAR(15) UNIQUE CHECK (phone ~ '^[0-9]+$'),
    status_id                 SMALLINT     NOT NULL REFERENCES login_status (id) DEFAULT 1,
    blood_group_id            SMALLINT NOT NULL REFERENCES blood_groups (id),
    marital_status_id         SMALLINT NOT NULL REFERENCES marital_statuses (id),
    marriage_anniversary_date DATE,
    date_of_birth             DATE,
    gender_id                 SMALLINT  NOT NULL REFERENCES genders (id),
    nationality               BIGINT  NOT NULL REFERENCES countries (id),
    created_at                TIMESTAMP    NOT NULL                              DEFAULT NOW(),
    updated_at                TIMESTAMP    NOT NULL                              DEFAULT NOW(),
    deleted_at                TIMESTAMP -- Soft delete,
        CONSTRAINT chk_phone_format CHECK (phone ~ '^[0-9]{10,15}$')
);

CREATE TABLE member_roles
(
    member_id BIGINT    NOT NULL REFERENCES members (id) ON DELETE CASCADE,
    role_id   SMALLINT  NOT NULL REFERENCES roles (id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'INACTIVE')),
    created_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (member_id, role_id), -- Ensure unique member-role combinations
    CONSTRAINT fk_member_roles_member_id FOREIGN KEY (member_id) REFERENCES members (id) ON DELETE CASCADE,
    CONSTRAINT fk_member_roles_role_id FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE CASCADE
);

COMMENT ON TABLE member_roles IS 'Maps members to their roles.';
COMMENT ON COLUMN member_roles.member_id IS 'The ID of the member.';
COMMENT ON COLUMN member_roles.role_id IS 'The ID of the role.';

CREATE TABLE member_role_history
(
    id          BIGSERIAL PRIMARY KEY,
    member_id   BIGINT    NOT NULL REFERENCES members (id) ON DELETE CASCADE,
    role_id     SMALLINT  NOT NULL REFERENCES roles (id) ON DELETE CASCADE,
    action      VARCHAR(10) NOT NULL CHECK (action IN ('ASSIGNED', 'REMOVED')), -- Track whether the role was assigned or removed
    performed_by BIGINT REFERENCES members (id), -- Who performed the action (if applicable)
    created_at  TIMESTAMP DEFAULT NOW(), -- When the action was performed
    CONSTRAINT unique_role_history UNIQUE (member_id, role_id, action, created_at)
);

ALTER TABLE member_role_history
    ALTER COLUMN action SET NOT NULL,
    ALTER COLUMN created_at SET NOT NULL;

-- Logins Table
CREATE TABLE logins
(
    id                    BIGSERIAL PRIMARY KEY,
    member_id             BIGINT      NOT NULL REFERENCES members (id) ON DELETE CASCADE,
    login_type            VARCHAR(50) NOT NULL CHECK (login_type IN ('EMAIL', 'OAUTH', 'BIOMETRIC')),

    -- Email Authentication
    email                 VARCHAR(320) UNIQUE CHECK (login_type = 'EMAIL'),
    password_hash         TEXT CHECK (login_type = 'EMAIL'),
    password_salt         TEXT CHECK (login_type = 'EMAIL'),
    password_last_changed TIMESTAMP            DEFAULT NOW(),
    password_expires_at   TIMESTAMP            DEFAULT (NOW() + INTERVAL '90 days'),

    -- OAuth Authentication
    provider_name         VARCHAR(50) CHECK (login_type = 'OAUTH'), -- Google, Facebook, etc.
    provider_user_id      VARCHAR(255) CHECK (login_type = 'OAUTH'),

    -- Biometric Authentication
    biometric_hash        TEXT CHECK (login_type = 'BIOMETRIC'),
    is_biometric_enabled  BOOLEAN              DEFAULT FALSE,

    login_status_id       SMALLINT    NOT NULL REFERENCES login_status (id),

    created_at            TIMESTAMP   NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMP   NOT NULL DEFAULT NOW(),

    UNIQUE (member_id, login_type, provider_name),-- Prevent duplicate authentication types per member
    CONSTRAINT chk_email_format CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT unique_email UNIQUE (email)
);

-- Member OTP Table
CREATE TABLE member_otp
(
    id          BIGSERIAL PRIMARY KEY,
    login_id    BIGINT      NOT NULL REFERENCES logins (id),
    otp_code    VARCHAR(10) NOT NULL,
    otp_type_id    SMALLINT     NOT NULL REFERENCES otp_types (id),
    created_at  TIMESTAMP   NOT NULL DEFAULT NOW(),
    expires_at  TIMESTAMP   NOT NULL,
    is_verified BOOLEAN              DEFAULT FALSE,
    UNIQUE (login_id, otp_type_id),
    CONSTRAINT unique_otp_code UNIQUE (otp_code)
);


-- Events Table
CREATE TABLE events
(
    id            BIGSERIAL PRIMARY KEY,
    organizer_id  BIGINT       NOT NULL REFERENCES members (id),
    name          VARCHAR(255) NOT NULL,
    description   TEXT,
    event_date    TIMESTAMP    NOT NULL,
    location      VARCHAR(255),
    event_type_id BIGINT       NOT NULL REFERENCES event_types (id),
    created_at    TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- Escalation Levels Table
CREATE TABLE escalation_levels
(
    id                  SMALLSERIAL PRIMARY KEY,
    sla_duration        INTERVAL NOT NULL,
    escalate_to_role_id BIGINT REFERENCES roles (id),
    description         TEXT
);

-- Priority Escalation Mapping Table
CREATE TABLE priority_escalation_mapping
(
    priority_id SMALLINT NOT NULL REFERENCES priorities (id),
    level_id    SMALLINT NOT NULL REFERENCES escalation_levels (id),
    UNIQUE (priority_id, level_id)
);

-- Tickets Table
CREATE TABLE tickets
(
    id            BIGSERIAL PRIMARY KEY,
    member_id       BIGINT    NOT NULL REFERENCES members (id),
    description   TEXT      NOT NULL,
    status_id     SMALLINT  NOT NULL REFERENCES ticket_statuses (id),
    current_level SMALLINT  NOT NULL DEFAULT 1 REFERENCES escalation_levels (id),
    priority_id   SMALLINT  NOT NULL REFERENCES priorities (id),
    assigned_to   BIGINT REFERENCES members (id),
    sla_due_at    TIMESTAMP,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW()
    --CONSTRAINT unique_ticket_description UNIQUE (description)
);

-- Ticket Logs Table
CREATE TABLE ticket_logs
(
    id            BIGSERIAL PRIMARY KEY,
    ticket_id     BIGINT    NOT NULL REFERENCES tickets (id) ON DELETE CASCADE,
    action_id     SMALLINT  NOT NULL REFERENCES log_actions (id),
    old_status_id SMALLINT REFERENCES ticket_statuses (id),
    new_status_id SMALLINT REFERENCES ticket_statuses (id),
    performed_by  BIGINT REFERENCES members (id),
    details       TEXT,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Define payments as a partitioned table
CREATE TABLE payments
(
    id             BIGSERIAL,
    member_id        BIGINT         NOT NULL REFERENCES members (id),
    event_id       BIGINT REFERENCES events (id),
    amount         DECIMAL(10, 2) NOT NULL,
    method_id      SMALLINT       NOT NULL REFERENCES payment_methods (id),
    payment_date   TIMESTAMP      NOT NULL DEFAULT NOW(),
    status         VARCHAR(20)    NOT NULL DEFAULT 'PENDING', -- PENDING, COMPLETED, FAILED
    transaction_id VARCHAR(255),
    created_at     TIMESTAMP               DEFAULT now(),
    updated_at     TIMESTAMP               DEFAULT now(),
    PRIMARY KEY (id, status)                                  -- Include the partition key (status) in the primary key
) PARTITION BY LIST (status);

-- Create partitions for payments
CREATE TABLE payments_pending PARTITION OF payments
    FOR VALUES IN ('PENDING');

CREATE TABLE payments_completed PARTITION OF payments
    FOR VALUES IN ('COMPLETED');

CREATE TABLE payments_failed PARTITION OF payments
    FOR VALUES IN ('FAILED');

-- Add a unique constraint on transaction_id (if needed)
-- Note: The unique constraint must include the partition key (status)
CREATE UNIQUE INDEX payments_transaction_id_unique
    ON payments (transaction_id, status);


-- Notifications Table
CREATE TABLE notifications
(
    id         BIGSERIAL PRIMARY KEY,
    member_id    BIGINT REFERENCES members (id),
    type_id    SMALLINT     NOT NULL REFERENCES notification_types (id),
    title      VARCHAR(255) NOT NULL,
    message    TEXT         NOT NULL,
    is_read    BOOLEAN               DEFAULT FALSE,
    created_at TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT unique_notification UNIQUE (member_id, type_id, title)
);

-- Define audit_logs as a partitioned table
CREATE TABLE audit_logs
(
    id             BIGSERIAL,
    table_name     VARCHAR(100) NOT NULL,
    operation      VARCHAR(50)  NOT NULL,
    record_id      BIGINT       NOT NULL,
    changed_by     BIGINT REFERENCES members (id),
    change_details JSONB,
    created_at     TIMESTAMP DEFAULT now(),
    PRIMARY KEY (id, created_at) -- Include the partition key in the primary key
) PARTITION BY RANGE (created_at);

-- Indexes for Performance
-- Members
CREATE INDEX idx_members_email ON logins (email);
CREATE INDEX idx_members_phone ON members (phone) WHERE deleted_at IS NULL;
CREATE INDEX idx_members_status ON members (status_id);
CREATE INDEX idx_member_roles_member_id ON member_roles (member_id);
CREATE INDEX idx_member_roles_role_id ON member_roles (role_id);
CREATE INDEX idx_member_role_history_member_id ON member_role_history (member_id);
CREATE INDEX idx_member_role_history_role_id ON member_role_history (role_id);

-- Addresses
CREATE INDEX idx_addresses_entity_type_city ON addresses (entity_id, city_id);

-- Events
CREATE INDEX idx_events_event_date ON events (event_date);

-- Payments
CREATE INDEX idx_payments_member_id ON payments (member_id);
CREATE INDEX idx_payments_event_id ON payments (event_id);
CREATE INDEX idx_payments_status ON payments (status);

-- Notifications
CREATE INDEX idx_notifications_member_id ON notifications (member_id);
CREATE INDEX idx_notifications_type_id ON notifications (type_id);
CREATE INDEX idx_notifications_is_read ON notifications (is_read);

-- Tickets
CREATE INDEX idx_tickets_status ON tickets (status_id);
CREATE INDEX idx_tickets_assigned_to ON tickets (assigned_to);
CREATE INDEX idx_tickets_member_priority_status ON tickets (member_id, priority_id, status_id);

-- Unique Constraints
ALTER TABLE tickets
    ADD CONSTRAINT unique_ticket_assignment UNIQUE (id, assigned_to);

ALTER TABLE audit_logs
    ADD CONSTRAINT unique_audit_entry UNIQUE (table_name, record_id, operation, created_at);

-- Audit Log Trigger
CREATE OR REPLACE FUNCTION audit_trigger_func()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO audit_logs (table_name, operation, record_id, changed_by, change_details, created_at)
    VALUES (TG_TABLE_NAME, TG_OP, NEW.id, NEW.id, row_to_json(NEW), NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER audit_members_trigger
    AFTER UPDATE
    ON members
    FOR EACH ROW
EXECUTE FUNCTION audit_trigger_func();

-- Function to create a new yearly partition
CREATE OR REPLACE FUNCTION create_yearly_partition() RETURNS VOID AS
$$
DECLARE
    current_year    INT  := EXTRACT(YEAR FROM NOW());
    next_year       INT  := current_year + 1;
    partition_name  TEXT := 'audit_logs_' || next_year;
    partition_start TEXT := next_year || '-01-01';
    partition_end   TEXT := (next_year + 1) || '-01-01';
BEGIN
    -- Check if the partition already exists
    IF NOT EXISTS (SELECT 1
                   FROM pg_class
                   WHERE relname = partition_name) THEN
        -- Create the partition
        EXECUTE format('
            CREATE TABLE %I PARTITION OF audit_logs
            FOR VALUES FROM (%L) TO (%L);
        ', partition_name, partition_start, partition_end);
        RAISE NOTICE 'Created partition: %', partition_name;
    ELSE
        RAISE NOTICE 'Partition % already exists', partition_name;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION assign_default_role()
    RETURNS TRIGGER AS
$$
BEGIN
    -- Assign the default role (e.g., USER with role_id = 1)
    INSERT INTO member_roles (member_id, role_id)
    VALUES (NEW.id, 1); -- Replace 1 with the default role_id
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER assign_default_role_trigger
    AFTER INSERT
    ON members
    FOR EACH ROW
EXECUTE FUNCTION assign_default_role();

CREATE OR REPLACE FUNCTION log_role_assignment()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO member_role_history (member_id, role_id, action, performed_by, created_at)
    VALUES (NEW.member_id, NEW.role_id, 'ASSIGNED', NEW.member_id, NOW()); -- Assuming the member performs the action
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_role_assignment_trigger
    AFTER INSERT
    ON member_roles
    FOR EACH ROW
EXECUTE FUNCTION log_role_assignment();

CREATE OR REPLACE FUNCTION log_role_removal()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO member_role_history (member_id, role_id, action, performed_by, created_at)
    VALUES (OLD.member_id, OLD.role_id, 'REMOVED', OLD.member_id, NOW()); -- Assuming the member performs the action
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_role_removal_trigger
    AFTER DELETE
    ON member_roles
    FOR EACH ROW
EXECUTE FUNCTION log_role_removal();

-- Create yearly partitions for audit_logs
CREATE TABLE audit_logs_2023 PARTITION OF audit_logs
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE audit_logs_2024 PARTITION OF audit_logs
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE audit_logs_2025 PARTITION OF audit_logs
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE audit_logs_2026 PARTITION OF audit_logs
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');