package com.tee.union.services.impl;

import com.tee.union.dao.UnionDao;
import com.tee.union.dto.Union;
import com.tee.union.services.UnionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class UnionServiceImpl implements UnionService {

    private final UnionDao unionDao;

    public UnionServiceImpl(UnionDao unionDao) {
        this.unionDao = unionDao;
    }

    @Override
    public List<Union> getAllUnions() {
        return unionDao.findAll();
    }

    @Override
    public Optional<Union> getUnionById(Long id) {
        return unionDao.findById(id);
    }

    @Override
    public Union createUnion(Union union) {
        return unionDao.save(union);
    }

    @Override
    public void updateUnion(Long id, Union union) {
        unionDao.update(id, union);
    }

    @Override
    public void deleteUnion(Long id) {
        unionDao.delete(id);
    }
}
