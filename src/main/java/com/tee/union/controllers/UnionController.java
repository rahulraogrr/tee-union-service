package com.tee.union.controllers;

import com.tee.union.dto.Union;
import com.tee.union.services.UnionService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Slf4j
@RestController
@RequestMapping("/api/v1/unions")
@Tag(name = "unions", description = "UnionController")
public class UnionController {
    private final UnionService unionService;

    public UnionController(UnionService unionService) {
        this.unionService = unionService;
    }

    @GetMapping
    public List<Union> getAllUnions() {
        return unionService.getAllUnions();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Union> getUnionById(@PathVariable Long id) {
        Optional<Union> union = unionService.getUnionById(id);
        return union.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Union> createUnion(@RequestBody Union union) {
        return ResponseEntity.ok(unionService.createUnion(union));
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateUnion(@PathVariable Long id, @RequestBody Union union) {
        unionService.updateUnion(id, union);
        return ResponseEntity.ok("Union updated successfully");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteUnion(@PathVariable Long id) {
        unionService.deleteUnion(id);
        return ResponseEntity.ok("Union deleted successfully");
    }
}
