Below is the **ticketing flow documentation** 

---

# Ticketing Flow Documentation

## 1. Ticket Creation
- **Who**: A member (e.g., customer, employee) creates a ticket.
- **What Happens**:
    - A new entry is added to the `tickets` table.
    - The ticket is assigned a `priority_id` based on the issue's urgency.
    - The `current_level` is set to `1` (initial escalation level).
    - The `sla_due_at` field is calculated based on the `sla_duration` of the escalation level mapped to the ticket's priority.
    - A detailed description of the issue is stored in the `ticket_details` table.
- **Example**:
    - A customer reports a login issue. The ticket is created with `priority_id = 1` (High) and `current_level = 1`.

---

## 2. Ticket Assignment
- **Who**: The system or an admin assigns the ticket to a member (e.g., support agent).
- **What Happens**:
    - The `assigned_to` field in the `tickets` table is updated with the ID of the assigned member.
    - A log entry is added to the `ticket_logs` table to record the assignment.
- **Example**:
    - The ticket is assigned to Agent John (ID = 5).

---

## 3. Ticket Resolution
- **Who**: The assigned member resolves the ticket.
- **What Happens**:
    - The `status_id` in the `tickets` table is updated to reflect the new status (e.g., "Resolved").
    - A log entry is added to the `ticket_logs` table to record the status change.
    - If resolved before the `sla_due_at`, the ticket is marked as "Resolved on Time."
    - If resolved after the `sla_due_at`, the ticket is marked as "Resolved Late."
- **Example**:
    - Agent John resolves the login issue and updates the ticket status to "Resolved."

---

## 4. Ticket Escalation
- **Who**: The system escalates the ticket if it is not resolved within the SLA duration.
- **What Happens**:
    - The `current_level` in the `tickets` table is incremented.
    - The `escalate_to_role_id` from the `escalation_levels` table determines the new role to which the ticket is escalated.
    - The `sla_due_at` is recalculated based on the new escalation level's `sla_duration`.
    - A log entry is added to the `ticket_logs` table to record the escalation.
- **Example**:
    - The login issue is not resolved within 24 hours. The ticket is escalated to Level 2, and the SLA is extended by another 24 hours.

---

## 5. Ticket Reopening
- **Who**: A member or system reopens the ticket if the issue persists.
- **What Happens**:
    - The `status_id` in the `tickets` table is updated to "Reopened."
    - A log entry is added to the `ticket_logs` table to record the reopening.
    - The ticket may be reassigned or escalated further.
- **Example**:
    - The customer reports that the login issue persists. The ticket is reopened and reassigned to Agent Jane.

---

## 6. Ticket Closure
- **Who**: The system or an admin closes the ticket.
- **What Happens**:
    - The `status_id` in the `tickets` table is updated to "Closed."
    - A log entry is added to the `ticket_logs` table to record the closure.
    - The ticket is marked as completed and no further actions are taken.
- **Example**:
    - The login issue is confirmed as resolved, and the ticket is closed.

---

## 7. Soft Deletion
- **Who**: An admin deletes a ticket (soft delete).
- **What Happens**:
    - The `deleted_at` field in the `tickets` table is updated with the current timestamp.
    - The ticket is no longer visible in active queries but remains in the database for auditing purposes.
- **Example**:
    - A duplicate ticket is soft-deleted by an admin.

---

# Possible Cases and Scenarios

## Case 1: Ticket Resolved Within SLA
1. Ticket is created with `priority_id = 1` (High) and `current_level = 1`.
2. SLA duration is 24 hours (`sla_due_at` is set to 24 hours from creation).
3. Ticket is assigned to Agent John.
4. Agent John resolves the ticket within 24 hours.
5. Ticket status is updated to "Resolved."

---

## Case 2: Ticket Escalation Due to SLA Breach
1. Ticket is created with `priority_id = 2` (Medium) and `current_level = 1`.
2. SLA duration is 48 hours (`sla_due_at` is set to 48 hours from creation).
3. Ticket is assigned to Agent Jane.
4. Agent Jane does not resolve the ticket within 48 hours.
5. Ticket is escalated to Level 2, and `sla_due_at` is extended by another 48 hours.
6. Ticket is reassigned to a senior agent.

---

## Case 3: Ticket Reopening
1. Ticket is created with `priority_id = 3` (Low) and `current_level = 1`.
2. SLA duration is 72 hours (`sla_due_at` is set to 72 hours from creation).
3. Ticket is assigned to Agent Mike.
4. Agent Mike resolves the ticket, but the customer reports the issue persists.
5. Ticket is reopened and reassigned to Agent Sarah.

---

## Case 4: Ticket Closure
1. Ticket is created with `priority_id = 1` (High) and `current_level = 1`.
2. SLA duration is 24 hours (`sla_due_at` is set to 24 hours from creation).
3. Ticket is assigned to Agent John.
4. Agent John resolves the ticket within 24 hours.
5. Ticket status is updated to "Resolved."
6. After confirmation, the ticket is closed.

---

## Case 5: Soft Deletion of a Ticket
1. Ticket is created with `priority_id = 2` (Medium) and `current_level = 1`.
2. Admin identifies the ticket as a duplicate.
3. Admin soft-deletes the ticket by setting `deleted_at` to the current timestamp.
4. Ticket is no longer visible in active queries but remains in the database.

---

# Visual Flow

```plaintext
Ticket Creation → Assignment → Resolution (Within SLA) → Closure
                   ↓
                   Escalation (SLA Breach) → Reassignment → Resolution → Closure
                   ↓
                   Reopening → Reassignment → Resolution → Closure
                   ↓
                   Soft Deletion
```

---

This Markdown document provides a clear and concise explanation of the ticketing flow, including all possible cases and scenarios. It is easy to share and can be rendered in any Markdown viewer or editor.