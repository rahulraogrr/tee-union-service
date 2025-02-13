package com.tee.union.config;

import org.junit.jupiter.api.BeforeAll;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Testcontainers;

@Testcontainers
public abstract class AbstractTestContainer {
    static final PostgreSQLContainer<?> POSTGRES_CONTAINER;
    static final GenericContainer<?> REDIS_CONTAINER;

    static {
        POSTGRES_CONTAINER = new PostgreSQLContainer<>("postgres:17.2")
                .withDatabaseName("testdb")
                .withUsername("testuser")
                .withPassword("testpass")
                .withInitScript("db/schema.sql"); // ✅ Ensures schema exists before Liquibase runs

        REDIS_CONTAINER = new GenericContainer<>("redis/redis-stack").withExposedPorts(6379);

        POSTGRES_CONTAINER.start();
        REDIS_CONTAINER.start();
    }


    @BeforeAll
    static void setUp() {
        System.setProperty("spring.datasource.url", POSTGRES_CONTAINER.getJdbcUrl());
        System.setProperty("spring.datasource.username", POSTGRES_CONTAINER.getUsername());
        System.setProperty("spring.datasource.password", POSTGRES_CONTAINER.getPassword());

        System.setProperty("spring.data.redis.host", REDIS_CONTAINER.getHost());
        System.setProperty("spring.data.redis.port", REDIS_CONTAINER.getMappedPort(6379).toString());
    }
}
