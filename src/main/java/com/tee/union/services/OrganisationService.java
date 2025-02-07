package com.tee.union.services;

import com.tee.union.dto.Organisation;

import java.util.List;
import java.util.Optional;

/**
 * An Organisation
 */
public interface OrganisationService {
    int createOrganisation(Organisation organisation);
    int updateOrganisation(Long id, Organisation organisation);
    int deleteOrganisation(Long id);
    List<Organisation> getAllOrganisations();
    Optional<Organisation> getOrganisationById(Long id);
}