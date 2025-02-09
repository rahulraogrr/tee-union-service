package com.tee.union;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class TeeUnionServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(TeeUnionServiceApplication.class, args);
    }

}
