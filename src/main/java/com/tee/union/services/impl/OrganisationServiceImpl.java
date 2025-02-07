package com.tee.union.services.impl;

import com.tee.union.dao.OrganisationDao;
import com.tee.union.dto.Organisation;
import com.tee.union.services.OrganisationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class OrganisationServiceImpl implements OrganisationService {
    private final OrganisationDao organisationDao;

    public OrganisationServiceImpl(OrganisationDao organisationDao) {
        this.organisationDao = organisationDao;
    }

    // Create a new organisation
    @Override
    public int createOrganisation(Organisation organisation) {
        return organisationDao.createOrganisation(organisation);
    }

    // Update an existing organisation
    @Override
    public int updateOrganisation(Long id, Organisation organisation) {
        return organisationDao.updateOrganisation(id, organisation);
    }

    // Delete an organisation
    @Override
    public int deleteOrganisation(Long id) {
        return organisationDao.deleteOrganisation(id);
    }

    // Get all organisations
    @Override
    public List<Organisation> getAllOrganisations() {
        return organisationDao.getAllOrganisations();
    }

    // Get organisation by ID
    @Override
    public Optional<Organisation> getOrganisationById(Long id) {
        return organisationDao.getOrganisationById(id);
    }
}
