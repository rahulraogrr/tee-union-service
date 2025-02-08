package com.tee.union.controllers;

import com.tee.union.dto.Organisation;
import com.tee.union.services.OrganisationService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Slf4j
@RestController
@RequestMapping("/api/v1/organisations")
@Tag(name = "organisations", description = "OrganisationController")
public class OrganisationController {
    private final OrganisationService organisationService;

    public OrganisationController(OrganisationService organisationService) {
        this.organisationService = organisationService;
    }

    // Get all organisations
    @GetMapping
    public List<Organisation> getAllOrganisations() {
        return organisationService.getAllOrganisations();
    }

    // Get organisation by ID
    @GetMapping("/{id}")
    public ResponseEntity<Organisation> getOrganisationById(@PathVariable Long id) {
        Optional<Organisation> organisation = organisationService.getOrganisationById(id);
        return organisation.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Create a new organisation
    @PostMapping
    public ResponseEntity<Organisation> createOrganisation(@RequestBody Organisation organisation) {
        int rowsAffected = organisationService.createOrganisation(organisation);
        return rowsAffected > 0 ? ResponseEntity.ok(organisation) : ResponseEntity.badRequest().build();
    }

    // Update an existing organisation
    @PutMapping("/{id}")
    public ResponseEntity<Organisation> updateOrganisation(@PathVariable Long id, @RequestBody Organisation organisation) {
        int rowsAffected = organisationService.updateOrganisation(id, organisation);
        return rowsAffected > 0 ? ResponseEntity.ok(organisation) : ResponseEntity.notFound().build();
    }

    // Delete an organisation
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrganisation(@PathVariable Long id) {
        int rowsAffected = organisationService.deleteOrganisation(id);
        return rowsAffected > 0 ? ResponseEntity.noContent().build() : ResponseEntity.notFound().build();
    }
}
