package com.tee.union.dao.impl;

import com.tee.union.dao.UnionDao;
import com.tee.union.dto.Union;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Slf4j
@Repository
public class UnionDaoImpl implements UnionDao {

    private final JdbcTemplate jdbcTemplate;

    public UnionDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<Union> rowMapper = (rs, rowNum) -> new Union(
            rs.getLong("id"),
            rs.getLong("organisation_id"),
            rs.getString("name"),
            rs.getString("description"),
            rs.getObject("created_at", LocalDateTime.class),
            rs.getObject("updated_at", LocalDateTime.class)
    );

    @Override
    @Cacheable(value = "unionsAll")
    public List<Union> findAll() {
        return jdbcTemplate.query("SELECT * FROM unions", rowMapper);
    }

    @Override
    @Cacheable(value = "unions", key = "#id")
    public Optional<Union> findById(Long id) {
        return jdbcTemplate.query("SELECT * FROM unions WHERE id = ?", rowMapper, id)
                .stream().findFirst();
    }

    @Override
    @CacheEvict(value = {"unions", "unionsAll"}, allEntries = true)
    public Union save(Union union) {
        return jdbcTemplate.queryForObject(
                "INSERT INTO unions (organisation_id, name, description) VALUES (?, ?, ?) RETURNING *",
                rowMapper,
                union.getOrganisationId(), union.getName(), union.getDescription()
        );
    }

    @Override
    @CacheEvict(value = {"unions", "unionsAll"}, allEntries = true)
    public void delete(Long id) {
        jdbcTemplate.update("DELETE FROM unions WHERE id = ?", id);
    }

    @Override
    @CacheEvict(value = {"unions", "unionsAll"}, allEntries = true)
    public void update(Long id, Union union) {
        jdbcTemplate.update(
                "UPDATE unions SET organisation_id = ?, name = ?, description = ?, updated_at = NOW() WHERE id = ?",
                union.getOrganisationId(), union.getName(), union.getDescription(), id
        );
    }
}
