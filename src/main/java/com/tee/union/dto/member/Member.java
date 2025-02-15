package com.tee.union.dto.member;

import lombok.*;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Member implements Serializable {
    private Long id;
    private Long unionId;
    private String firstName;
    private String middleName;
    private String lastName;
    private String phone;
    private Long statusId;
    private Long bloodGroupId;
    private Long maritalStatusId;
    private LocalDate marriageAnniversaryDate;
    private LocalDate dateOfBirth;
    private Long genderId;
    private Long nationality;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private LocalDateTime deletedAt;
}