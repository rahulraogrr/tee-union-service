package com.tee.union.dao.impl;

import com.tee.union.dao.OrganisationDao;
import com.tee.union.dto.Organisation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Slf4j
@Repository
public class OrganisationDaoImpl implements OrganisationDao {
    private final JdbcTemplate jdbcTemplate;

    public OrganisationDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Create a new organisation
    @Override
    @CacheEvict(value = {"organisations", "organisation"}, allEntries = true)
    public int createOrganisation(Organisation organisation) {
        String sql = "INSERT INTO organisations (name, description, created_at, updated_at) VALUES (?, ?, NOW(), NOW())";
        return jdbcTemplate.update(sql, organisation.getName(), organisation.getDescription());
    }

    // Update an existing organisation
    @Override
    @CacheEvict(value = {"organisations", "organisation"}, allEntries = true)
    public int updateOrganisation(Long id, Organisation organisation) {
        String sql = "UPDATE organisations SET name = ?, description = ?, updated_at = NOW() WHERE id = ?";
        return jdbcTemplate.update(sql, organisation.getName(), organisation.getDescription(), id);
    }

    // Delete an organisation
    @Override
    @CacheEvict(value = {"organisations", "organisation"}, allEntries = true)
    public int deleteOrganisation(Long id) {
        // Check if any unions exist for this organisation
        String checkUnionsSql = "SELECT COUNT(*) FROM unions WHERE organisation_id = ?";
        int unionCount = jdbcTemplate.queryForObject(checkUnionsSql, Integer.class, id);

        if (unionCount > 0) {
            throw new IllegalStateException("Cannot delete organisation with existing unions");
        }

        // Proceed with deletion
        String sql = "DELETE FROM organisations WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }

    // Get all organisations
    @Override
    @Cacheable(value = "organisations")
    public List<Organisation> getAllOrganisations() {
        String sql = "SELECT * FROM organisations";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Organisation.class));
    }

    // Get organisation by ID
    @Override
    @Cacheable(value = "organisation", key = "#id")
    public Optional<Organisation> getOrganisationById(Long id) {
        String sql = "SELECT * FROM organisations WHERE id = ?";
        List<Organisation> organisations = jdbcTemplate.query(sql, new Object[]{id}, new BeanPropertyRowMapper<>(Organisation.class));
        return organisations.isEmpty() ? Optional.empty() : Optional.of(organisations.get(0));
    }
}
