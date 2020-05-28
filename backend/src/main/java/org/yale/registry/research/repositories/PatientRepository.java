package org.yale.registry.research.repositories;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.yale.registry.research.entities.PatientEntity;

import java.util.List;

public interface PatientRepository extends PagingAndSortingRepository<PatientEntity, Long> {
    List<PatientEntity> findPatientEntitiesByName(String name);
}
