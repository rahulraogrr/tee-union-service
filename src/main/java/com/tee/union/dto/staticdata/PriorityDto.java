package com.tee.union.dto.staticdata;

import lombok.*;

import java.time.Duration;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PriorityDto extends BaseLookupDto {
    private Duration slaDuration;
    private int weight;
}