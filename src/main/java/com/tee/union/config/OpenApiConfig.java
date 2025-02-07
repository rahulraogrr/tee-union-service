package com.tee.union.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Value("${spring.application.name}")
    private String appName;

    @Value("${project.version}")
    private String appVersion;

    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI().info(
                new Info().title(appName)
                        .description("Telangana Electricity Employees 1104' Documentation")
                        .version(appVersion)
                        .contact(new Contact().name("HMS").name("Rahul Rao Gonda").email("rahulrao.gla@gmail.com")));
    }

}