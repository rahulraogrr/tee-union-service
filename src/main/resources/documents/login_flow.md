Here’s the **member login flow** explained in **Markdown (MD)** format, focusing on the **step-by-step process** for all login types and scenarios, without including table structures.

---

# Member Login Flow Documentation

## Overview
The member login system supports multiple authentication methods, including **email**, **OAuth**, **biometric**, and **mobile-based logins**. It also incorporates **multi-factor authentication (MFA)** and robust security features like **login history tracking**, **failed login attempts tracking**, and **IP blocking** to prevent brute-force attacks.

---

## Login Flow

### **1. Member Initiates Login**
- The member selects a login method:
    - **Email**: Enter email and password.
    - **OAuth**: Use third-party providers like Google or Facebook.
    - **Biometric**: Use fingerprint or face scan.
    - **Mobile**: Enter mobile number and OTP.

---

### **2. Validate Login Method**
- The system checks if the selected login method is enabled for the member.
- If the method is not enabled, the member is prompted to use an alternative method.

---

### **3. Authentication Process**
#### **Email Login**
1. Member enters their email and password.
2. System verifies:
    - Email format (`example@domain.com`).
    - Password matches the stored hash and salt.
3. If valid, proceed to **Step 4**.
4. If invalid, increment failed login attempts and log the failure.

#### **OAuth Login**
1. Member selects a provider (e.g., Google, Facebook).
2. System redirects to the provider’s authentication page.
3. Member logs in via the provider.
4. Provider returns a unique user ID.
5. System verifies the user ID against stored OAuth credentials.
6. If valid, proceed to **Step 4**.

#### **Biometric Login**
1. Member uses their device’s biometric scanner (fingerprint, face scan).
2. System verifies the biometric hash against stored data.
3. If valid, proceed to **Step 4**.

#### **Mobile Login**
1. Member enters their mobile number.
2. System sends an OTP to the mobile number.
3. Member enters the OTP.
4. System verifies the OTP.
5. If valid, proceed to **Step 4**.

---

### **4. Check Login Status**
- The system checks the member’s login status:
    - **Active**: Proceed to **Step 5**.
    - **Locked**: Notify the member and block further attempts.
    - **Expired**: Prompt the member to reset their password.
    - **Inactive**: Notify the member to activate their account.
    - **Banned**: Notify the member that their account is banned.

---

### **5. Multi-Factor Authentication (MFA)**
- If MFA is enabled for the member:
    1. System prompts the member for a second factor:
        - **TOTP**: Enter a time-based OTP from an authenticator app.
        - **SMS**: Enter an OTP sent to their mobile number.
        - **Email**: Enter an OTP sent to their email.
        - **Biometric**: Perform a biometric scan.
    2. System verifies the second factor.
    3. If valid, proceed to **Step 6**.

---

### **6. Log Successful Login**
- The system logs the successful login attempt in the `login_history` table.
- Updates the member’s last login timestamp.

---

### **7. Grant Access**
- The member is granted access to their account.
- A session is created, and the member is redirected to their dashboard.

---

## Failed Login Flow

### **1. Increment Failed Attempts**
- For each failed login attempt:
    1. Log the failure in the `failed_logins` table.
    2. Increment the failed attempt counter.

---

### **2. Check for IP Blocking**
- If the number of failed attempts from the same IP exceeds a threshold:
    1. Block the IP address for a specified duration (e.g., 30 minutes).
    2. Log the blocked IP in the `blocked_ips` table.

---

### **3. Notify Member**
- Notify the member of the failed attempt:
    - If the account is locked, provide instructions to unlock it.
    - If the IP is blocked, notify the member to try again later.

---

## Account Recovery Flow

### **1. Member Requests Password Reset**
- Member clicks "Forgot Password" and enters their email or mobile number.

---

### **2. Verify Member Identity**
- System sends an OTP or reset link to the member’s email or mobile number.

---

### **3. Reset Password**
- Member enters the OTP or clicks the reset link.
- Member sets a new password.
- System updates the password hash and salt.

---

## Multi-Factor Authentication (MFA) Flow

### **1. Enable MFA**
- Member selects MFA methods (e.g., TOTP, SMS, email, biometric).
- System generates backup codes and stores MFA settings.

---

### **2. Verify MFA**
- During login, if MFA is enabled:
    1. System prompts the member for the second factor.
    2. Member enters the OTP or performs a biometric scan.
    3. System verifies the second factor.

---

### **3. Disable MFA**
- Member can disable MFA from their account settings.
- System removes MFA settings and backup codes.

---

## Security Features

### **1. Login History Tracking**
- Every login attempt (successful or failed) is logged in the `login_history` table.
- Includes details like IP address, user agent, and timestamp.

---

### **2. Failed Login Tracking**
- Failed login attempts are logged in the `failed_logins` table.
- Used to detect and prevent brute-force attacks.

---

### **3. IP Blocking**
- If an IP exceeds the allowed number of failed attempts:
    1. The IP is blocked for a specified duration.
    2. Blocked IPs are logged in the `blocked_ips` table.

---

### **4. Password Expiry**
- Passwords expire after 90 days.
- Members are prompted to reset their password before expiry.

---

## Example Scenarios

### **Scenario 1: Successful Email Login**
1. Member enters email and password.
2. System verifies credentials.
3. MFA is enabled: Member enters TOTP.
4. System logs the successful login.
5. Member is granted access.

---

### **Scenario 2: Failed OAuth Login**
1. Member selects Google OAuth.
2. Authentication fails (e.g., invalid token).
3. System logs the failed attempt.
4. Notifies the member of the failure.

---

### **Scenario 3: Account Locked**
1. Member enters incorrect password 5 times.
2. System locks the account.
3. Notifies the member to contact support.

---

### **Scenario 4: IP Blocked**
1. Multiple failed login attempts from the same IP.
2. System blocks the IP for 30 minutes.
3. Notifies the member to try again later.

---

This Markdown document provides a **clear and concise explanation** of the member login flow, including all possible scenarios and security features. It is designed for easy readability and understanding.