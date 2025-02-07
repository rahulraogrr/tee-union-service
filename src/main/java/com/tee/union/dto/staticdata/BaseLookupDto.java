package com.tee.union.dto.staticdata;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public abstract class BaseLookupDto {
    private Integer id;
    private String name;
    private String description;
}