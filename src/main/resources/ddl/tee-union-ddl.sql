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
DROP TABLE IF EXISTS login_history CASCADE;
DROP TABLE IF EXISTS failed_logins CASCADE;
DROP TABLE IF EXISTS blocked_ips CASCADE;
DROP TABLE IF EXISTS payment_status CASCADE;
DROP TABLE IF EXISTS member_role_history CASCADE;
DROP TABLE IF EXISTS companies CASCADE;
DROP TABLE IF EXISTS sectors CASCADE;
DROP TABLE IF EXISTS ownership_type CASCADE;
DROP TABLE IF EXISTS otp_types CASCADE;
DROP TABLE IF EXISTS member_otp CASCADE;
DROP TABLE IF EXISTS blood_groups CASCADE;
DROP TABLE IF EXISTS login_types CASCADE;
DROP TABLE IF EXISTS ticket_details CASCADE;
DROP TABLE IF EXISTS email_logins CASCADE;
DROP TABLE IF EXISTS oauth_logins CASCADE;
DROP TABLE IF EXISTS biometric_logins CASCADE;
DROP TABLE IF EXISTS mobile_logins CASCADE;
DROP TABLE IF EXISTS mfa_types CASCADE;
DROP TABLE IF EXISTS mfa_settings CASCADE;
DROP TABLE IF EXISTS mfa_challenges CASCADE;
DROP TABLE IF EXISTS mfa_settings CASCADE;
DROP TABLE IF EXISTS databasechangelog CASCADE;
DROP TABLE IF EXISTS databasechangeloglock CASCADE;


-- Entity Type Table
CREATE TABLE mfa_types
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN ('TOTP', 'SMS', 'EMAIL', 'BIOMETRIC', 'BACKUP_CODE')),
    description TEXT,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

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
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN ('ACTIVE', 'INACTIVE', 'RETIRED','UNDER_VERIFICATION','CREATED')),
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
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN ('EVENT_UPDATE', 'ANNOUNCEMENT', 'EMERGENCY','SECURITY_ALERT')),
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
                                                   ('EMAIL', 'SMS', 'WHATSAPP')),
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

CREATE TABLE login_types
(
    id          SMALLSERIAL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE CHECK (name IN ('EMAIL', 'OAUTH', 'BIOMETRIC','MOBILE')),
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
    id         SMALLSERIAL PRIMARY KEY,
    name       VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);

-- Regions Table
CREATE TABLE regions
(
    id         SMALLSERIAL PRIMARY KEY,
    name       VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);

-- Countries Table
CREATE TABLE countries
(
    id             SMALLSERIAL PRIMARY KEY,
    name           VARCHAR(100) NOT NULL UNIQUE,
    iso_alpha2     CHAR(2)      NOT NULL UNIQUE,
    iso_alpha3     CHAR(3)      NOT NULL UNIQUE,
    telephone_code VARCHAR(10)  NOT NULL,
    lcy            CHAR(3)      NOT NULL,
    region_id      SMALLINT     NOT NULL REFERENCES regions (id) ON DELETE CASCADE,
    status_id      SMALLINT     NOT NULL REFERENCES political_status (id) ON DELETE RESTRICT,
    created_at     TIMESTAMP DEFAULT now(),
    updated_at     TIMESTAMP DEFAULT now()
);

-- States Table
CREATE TABLE states
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    code       VARCHAR(10) UNIQUE,
    country_id SMALLINT NOT NULL REFERENCES countries (id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now(),
    CONSTRAINT unique_state_per_country UNIQUE (name, country_id)
);

-- Districts Table
CREATE TABLE districts
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    state_id   INT NOT NULL REFERENCES states (id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now(),
    CONSTRAINT unique_district_per_state UNIQUE (name, state_id)
);

-- Cities Table
CREATE TABLE cities
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    district_id INT NOT NULL REFERENCES districts (id) ON DELETE CASCADE,
    created_at  TIMESTAMP DEFAULT now(),
    updated_at  TIMESTAMP DEFAULT now(),
    CONSTRAINT unique_city_per_district UNIQUE (name, district_id)
);

-- Addresses Table
CREATE TABLE addresses
(
    id            BIGSERIAL PRIMARY KEY,
    entity_id     SMALLINT NOT NULL REFERENCES entity_type (id), -- Ensure entity_type table exists
    house_no      VARCHAR(255),
    building_name VARCHAR(255),
    street        VARCHAR(255) NOT NULL,
    locality      VARCHAR(255),
    landmark      VARCHAR(255),
    postal_code   VARCHAR(20),
    city_id       INT NOT NULL REFERENCES cities (id),
    type_id       SMALLINT NOT NULL REFERENCES address_types (id), -- Ensure address_types table exists
    created_at    TIMESTAMP NOT NULL DEFAULT now(),
    updated_at    TIMESTAMP NOT NULL DEFAULT now()
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
    status_id                 SMALLINT     NOT NULL REFERENCES user_statuses (id),
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

-- 🚀 Authentication: Logins Table
CREATE TABLE logins
(
    id             BIGSERIAL PRIMARY KEY,
    member_id      BIGINT NOT NULL REFERENCES members (id) ON DELETE CASCADE,
    login_type_id  SMALLINT NOT NULL REFERENCES login_types (id),
    login_status_id SMALLINT NOT NULL REFERENCES login_status (id),
    created_at     TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at     TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (member_id, login_type_id)
);

-- 📧 Email-Based Logins
CREATE TABLE email_logins
(
    id                    BIGSERIAL PRIMARY KEY,
    login_id              BIGINT NOT NULL REFERENCES logins (id) ON DELETE CASCADE,
    email                 VARCHAR(320) NOT NULL UNIQUE,
    password_hash         TEXT NOT NULL,
    password_last_changed TIMESTAMP DEFAULT NOW(),
    password_expires_at   TIMESTAMP DEFAULT (NOW() + INTERVAL '90 days'),
    CONSTRAINT chk_email_format CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

-- 🔗 OAuth-Based Logins (Google, Facebook, etc.)
CREATE TABLE oauth_logins
(
    id              BIGSERIAL PRIMARY KEY,
    login_id        BIGINT NOT NULL REFERENCES logins (id) ON DELETE CASCADE,
    provider_name   VARCHAR(50) NOT NULL,
    provider_user_id VARCHAR(255) NOT NULL,
    UNIQUE (provider_name, provider_user_id)
);

-- 🛡️ Biometric-Based Logins
CREATE TABLE biometric_logins
(
    id               BIGSERIAL PRIMARY KEY,
    login_id         BIGINT NOT NULL REFERENCES logins (id) ON DELETE CASCADE,
    biometric_hash   TEXT NOT NULL,
    is_biometric_enabled BOOLEAN DEFAULT FALSE
);

-- 📱 Mobile Number-Based Logins
CREATE TABLE mobile_logins
(
    id            BIGSERIAL PRIMARY KEY,
    login_id      BIGINT NOT NULL REFERENCES logins (id) ON DELETE CASCADE,
    mobile_number VARCHAR(15) NOT NULL UNIQUE,
    CONSTRAINT chk_mobile_format CHECK (mobile_number ~ '^\+\d{1,14}$')
);

-- 🔐 Multi-Factor Authentication (MFA) Settings
CREATE TABLE mfa_settings
(
    id                  BIGSERIAL PRIMARY KEY,
    member_id           BIGINT NOT NULL REFERENCES members (id) ON DELETE CASCADE,
    is_totp_enabled     BOOLEAN DEFAULT FALSE,
    is_sms_enabled      BOOLEAN DEFAULT FALSE,
    is_email_enabled    BOOLEAN DEFAULT FALSE,
    is_biometric_enabled BOOLEAN DEFAULT FALSE,
    backup_codes        TEXT[],
    created_at          TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (member_id)
);

-- 🔑 MFA Challenges (Tracks MFA Verification Attempts)
CREATE TABLE mfa_challenges
(
    id              BIGSERIAL PRIMARY KEY,
    login_id        BIGINT NOT NULL REFERENCES logins (id) ON DELETE CASCADE,
    mfa_type_id     SMALLINT NOT NULL REFERENCES mfa_types (id),
    otp_code        VARCHAR(10) NOT NULL,
    expires_at      TIMESTAMP NOT NULL DEFAULT (NOW() + INTERVAL '5 minutes'),
    is_verified     BOOLEAN DEFAULT FALSE,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
    --CONSTRAINT unique_active_mfa UNIQUE (login_id, mfa_type_id, is_verified) WHERE is_verified = FALSE
);

-- ✅ Enforce unique active (unverified) MFA challenges per login
CREATE UNIQUE INDEX unique_active_mfa_idx
    ON mfa_challenges (login_id, mfa_type_id)
    WHERE is_verified = FALSE;

-- 📜 Login History Tracking
CREATE TABLE login_history
(
    id          BIGSERIAL PRIMARY KEY,
    login_id    BIGINT NOT NULL REFERENCES logins (id) ON DELETE CASCADE,
    ip_address  INET NOT NULL,
    user_agent  TEXT NOT NULL,
    success     BOOLEAN NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 🚨 Brute-Force Protection: Track Failed Logins
CREATE TABLE failed_logins
(
    id          BIGSERIAL PRIMARY KEY,
    login_id    BIGINT NOT NULL REFERENCES logins (id) ON DELETE CASCADE,
    ip_address  INET NOT NULL,
    failed_at   TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 🛑 Blocked IPs Table (Auto Blocking System)
CREATE TABLE blocked_ips
(
    id             BIGSERIAL PRIMARY KEY,
    ip_address     INET NOT NULL UNIQUE,
    blocked_until  TIMESTAMP NOT NULL DEFAULT (NOW() + INTERVAL '30 minutes'),
    attempt_count  SMALLINT NOT NULL DEFAULT 1, -- Track repeated offenses
    created_at     TIMESTAMP NOT NULL DEFAULT NOW()
);

-- ✅ Indexes for Faster Lookups
CREATE INDEX idx_failed_logins ON failed_logins (login_id, ip_address);
CREATE INDEX idx_login_history ON login_history (login_id, created_at);
CREATE INDEX idx_mfa_challenges ON mfa_challenges (login_id, mfa_type_id);
CREATE INDEX idx_blocked_ips ON blocked_ips (ip_address);

-- 📩 Notifications Table
CREATE TABLE notifications
(
    id                  BIGSERIAL PRIMARY KEY,
    member_id           BIGINT REFERENCES members (id) ON DELETE CASCADE,
    notification_type_id SMALLINT NOT NULL REFERENCES notification_types (id),
    title               VARCHAR(255) NOT NULL,
    message             TEXT NOT NULL,
    is_read             BOOLEAN DEFAULT FALSE,
    created_at          TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT unique_notification UNIQUE (member_id, notification_type_id, title)
);

-- ✅ Indexes for Notifications
CREATE INDEX idx_notifications ON notifications (member_id, notification_type_id, is_read);
CREATE INDEX idx_notifications_member_id ON notifications (member_id);
CREATE INDEX idx_notifications_is_read ON notifications (is_read);

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
    escalate_to_role_id BIGINT REFERENCES roles (id) ON UPDATE CASCADE,
    description         TEXT,
    created_at          TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE escalation_levels IS 'Stores escalation levels for tickets, including SLA duration and target role.';
COMMENT ON COLUMN escalation_levels.sla_duration IS 'The duration within which the ticket should be resolved at this escalation level.';

-- Priority Escalation Mapping Table
CREATE TABLE priority_escalation_mapping
(
    priority_id SMALLINT NOT NULL REFERENCES priorities (id) ON UPDATE CASCADE,
    level_id    SMALLINT NOT NULL REFERENCES escalation_levels (id) ON UPDATE CASCADE,
    created_at  TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (priority_id, level_id)
);

COMMENT ON TABLE priority_escalation_mapping IS 'Maps ticket priorities to escalation levels.';

-- Tickets Table
CREATE TABLE tickets
(
    id            BIGSERIAL PRIMARY KEY,
    member_id     BIGINT    NOT NULL REFERENCES members (id) ON UPDATE CASCADE,
    status_id     SMALLINT  NOT NULL REFERENCES ticket_statuses (id) ON UPDATE CASCADE,
    current_level SMALLINT  NOT NULL DEFAULT 1 REFERENCES escalation_levels (id) ON UPDATE CASCADE,
    priority_id   SMALLINT  NOT NULL REFERENCES priorities (id) ON UPDATE CASCADE,
    assigned_to   BIGINT REFERENCES members (id) ON UPDATE CASCADE,
    sla_due_at    TIMESTAMP,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    deleted_at    TIMESTAMP,
    CONSTRAINT chk_sla_due_at CHECK (sla_due_at > created_at)
);

COMMENT ON TABLE tickets IS 'Stores ticket information, including status, priority, and escalation level.';
COMMENT ON COLUMN tickets.sla_due_at IS 'The timestamp by which the ticket should be resolved based on the SLA.';

-- Ticket Details Table (Normalized from Tickets Table)
CREATE TABLE ticket_details
(
    ticket_id   BIGINT NOT NULL REFERENCES tickets (id) ON DELETE CASCADE,
    description TEXT   NOT NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (ticket_id)
);

COMMENT ON TABLE ticket_details IS 'Stores detailed descriptions of tickets, normalized from the tickets table.';

-- Ticket Logs Table
CREATE TABLE ticket_logs
(
    id            BIGSERIAL PRIMARY KEY,
    ticket_id     BIGINT    NOT NULL REFERENCES tickets (id) ON DELETE CASCADE,
    action_id     SMALLINT  NOT NULL REFERENCES log_actions (id) ON UPDATE CASCADE,
    old_status_id SMALLINT REFERENCES ticket_statuses (id) ON UPDATE CASCADE,
    new_status_id SMALLINT REFERENCES ticket_statuses (id) ON UPDATE CASCADE,
    performed_by  BIGINT REFERENCES members (id) ON UPDATE CASCADE,
    details       TEXT,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    deleted_at    TIMESTAMP,
    CONSTRAINT chk_status_change CHECK (old_status_id IS DISTINCT FROM new_status_id)
);

COMMENT ON TABLE ticket_logs IS 'Logs all actions performed on tickets, including status changes and updates.';

-- Indexes for Performance
CREATE INDEX idx_tickets_priority_id ON tickets (priority_id);
CREATE INDEX idx_tickets_status_id ON tickets (status_id);
CREATE INDEX idx_ticket_logs_ticket_id ON ticket_logs (ticket_id);
CREATE INDEX idx_ticket_logs_action_id ON ticket_logs (action_id);

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