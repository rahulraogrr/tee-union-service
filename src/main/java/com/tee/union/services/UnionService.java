package com.tee.union.services;

import com.tee.union.dto.Union;

import java.util.List;
import java.util.Optional;

public interface UnionService {
    List<Union> getAllUnions();
    Optional<Union> getUnionById(Long id);
    Union createUnion(Union union);
    void updateUnion(Long id, Union union);
    void deleteUnion(Long id);
}