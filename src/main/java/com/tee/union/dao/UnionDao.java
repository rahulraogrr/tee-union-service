package com.tee.union.dao;

import com.tee.union.dto.Union;

import java.util.List;
import java.util.Optional;

public interface UnionDao {
    List<Union> findAll();
    Optional<Union> findById(Long id);
    Union save(Union union);
    void delete(Long id);
    void update(Long id, Union union);
}
