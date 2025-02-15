Below is a detailed **Markdown (`.md`) document** explaining the **Login Module** in your system, covering how different login methods work, security measures, and possible exceptions.

---

# 🚀 Login Module: Detailed Explanation

## 🔹 Overview
The **Login Module** in our system provides multiple authentication mechanisms for users, ensuring both security and flexibility. Users can log in using:

1. **Email & Password**
2. **OAuth (Google, Facebook, etc.)**
3. **Biometric Authentication**
4. **Mobile Number OTP**
5. **Multi-Factor Authentication (MFA)**

Each method follows strict validation rules and security measures, including brute-force protection, MFA challenges, and login history tracking.

---

## 🏗 **Database Schema Overview**
The system consists of the following key tables:

### 1️⃣ `logins` - **Tracks All Logins**
| Column         | Type       | Description |
|---------------|-----------|-------------|
| `id`          | `BIGSERIAL` | Primary key |
| `member_id`   | `BIGINT`   | References `members(id)` |
| `login_type_id` | `SMALLINT` | References `login_types(id)` |
| `login_status_id` | `SMALLINT` | References `login_status(id)` |
| `created_at`  | `TIMESTAMP` | Auto-filled timestamp |
| `updated_at`  | `TIMESTAMP` | Auto-updated timestamp |

✅ **Ensures unique login types per user:**
```sql
UNIQUE (member_id, login_type_id)
```

---

### 2️⃣ `email_logins` - **Email & Password Authentication**
| Column        | Type        | Description |
|--------------|------------|-------------|
| `id`         | `BIGSERIAL` | Primary key |
| `login_id`   | `BIGINT`    | References `logins(id)` |
| `email`      | `VARCHAR(320)` | Unique email ID |
| `password_hash` | `TEXT`    | Hashed password |
| `password_last_changed` | `TIMESTAMP` | Password last change timestamp |
| `password_expires_at` | `TIMESTAMP` | Expiry after 90 days |

✅ **Enforces valid email format:**
```sql
CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
```

---

### 3️⃣ `oauth_logins` - **OAuth (Google, Facebook, etc.)**
| Column          | Type         | Description |
|----------------|-------------|-------------|
| `id`           | `BIGSERIAL`  | Primary key |
| `login_id`     | `BIGINT`     | References `logins(id)` |
| `provider_name` | `VARCHAR(50)` | Provider (Google, Facebook, etc.) |
| `provider_user_id` | `VARCHAR(255)` | Unique ID from provider |

✅ **Ensures uniqueness per provider:**
```sql
UNIQUE (provider_name, provider_user_id)
```

---

### 4️⃣ `biometric_logins` - **Fingerprint/Face ID Authentication**
| Column        | Type       | Description |
|--------------|-----------|-------------|
| `id`         | `BIGSERIAL` | Primary key |
| `login_id`   | `BIGINT`    | References `logins(id)` |
| `biometric_hash` | `TEXT` | Securely stored biometric data |
| `is_biometric_enabled` | `BOOLEAN` | Enables/disables biometric login |

---

### 5️⃣ `mobile_logins` - **Phone Number Login (OTP)**
| Column       | Type        | Description |
|-------------|------------|-------------|
| `id`        | `BIGSERIAL` | Primary key |
| `login_id`  | `BIGINT`    | References `logins(id)` |
| `mobile_number` | `VARCHAR(15)` | Unique mobile number |

✅ **Ensures valid mobile format:**
```sql
CHECK (mobile_number ~ '^\+\d{1,14}$')
```

---

### 6️⃣ `mfa_challenges` - **Multi-Factor Authentication**
| Column       | Type        | Description |
|-------------|------------|-------------|
| `id`        | `BIGSERIAL` | Primary key |
| `login_id`  | `BIGINT`    | References `logins(id)` |
| `mfa_type_id` | `SMALLINT` | MFA method (TOTP, SMS, Email) |
| `otp_code`  | `VARCHAR(10)` | OTP sent to user |
| `expires_at` | `TIMESTAMP` | Expiry (5 minutes) |
| `is_verified` | `BOOLEAN` | True if verified |

✅ **Enforces unique active MFA challenges per login:**
```sql
CREATE UNIQUE INDEX unique_active_mfa_idx 
ON mfa_challenges (login_id, mfa_type_id) 
WHERE is_verified = FALSE;
```

---

### 7️⃣ `login_history` - **Tracking Successful Logins**
| Column        | Type      | Description |
|--------------|----------|-------------|
| `id`         | `BIGSERIAL` | Primary key |
| `member_id`  | `BIGINT` | References `members(id)` |
| `ip_address` | `INET`   | Logged IP address |
| `user_agent` | `TEXT`   | Device/browser info |
| `success`    | `BOOLEAN` | Login success/failure |

---

### 8️⃣ `failed_logins` - **Brute-Force Protection**
| Column       | Type     | Description |
|-------------|---------|-------------|
| `id`        | `BIGSERIAL` | Primary key |
| `member_id` | `BIGINT` | References `members(id)` |
| `ip_address` | `INET` | Failed attempt IP |
| `failed_at` | `TIMESTAMP` | Timestamp of failure |

✅ **Indexes for faster lookups:**
```sql
CREATE INDEX idx_failed_logins ON failed_logins (member_id, ip_address);
```

---

## 🔐 **How Login Works**
### 1️⃣ **User Attempts Login**
- Enters email, mobile, or OAuth provider details.
- System checks credentials in `logins` table.

### 2️⃣ **Verification Process**
- **Email/Password** → Match with `email_logins.password_hash`
- **OAuth** → Check against `oauth_logins.provider_user_id`
- **Biometric** → Compare `biometric_hash`
- **Mobile OTP** → Validate against `mobile_logins`
- **MFA Enabled?** → Check `mfa_challenges`

### 3️⃣ **Success or Failure Handling**
- On **Success**:
    - Record in `login_history`
    - Generate session token
- On **Failure**:
    - Record in `failed_logins`
    - Block IP after multiple failures

---

## ⚠️ **Exceptions & Security Measures**
| Issue | Handling Strategy |
|------|-----------------|
| Incorrect password | Limit retries (e.g., 5 attempts) |
| Expired password | Force password reset |
| Invalid OAuth response | Deny login |
| Biometric mismatch | Fallback to password login |
| Multiple MFA failures | Temporary lock account |
| Brute-force attack | Auto-block IP for 30 minutes |

✅ **Blocking Malicious Logins:**
```sql
CREATE TABLE blocked_ips (
    id         BIGSERIAL PRIMARY KEY,
    ip_address INET NOT NULL UNIQUE,
    blocked_until TIMESTAMP NOT NULL DEFAULT (NOW() + INTERVAL '30 minutes')
);
```

---

## 🎯 **Final Thoughts**
This login module ensures:
✔️ **Multiple authentication options**  
✔️ **Secure storage of credentials**  
✔️ **Brute-force attack prevention**  
✔️ **Multi-factor authentication for extra security**

By implementing these measures, we ensure a **safe and user-friendly authentication experience**! 🚀

---
