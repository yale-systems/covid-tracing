package org.yale.registry.research.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.DTOs.VolunteerDTO;
import org.yale.registry.research.entities.PatientEntity;

import java.util.List;
import java.util.Optional;

public interface PatientRepository extends PagingAndSortingRepository<PatientEntity, Long> {
    @Query("SELECT p from PatientEntity p WHERE p.patient_id = :patient_id")
    public Optional<PatientEntity> findPatientEntityByPatient_id(@Param("patient_id") Long patient_id);

    @Query("SELECT p from PatientEntity p WHERE p.manager_id = :manager_id ORDER BY p.patient_id")
    public List<PatientEntity> findPatientEntitiesByManager_id(@Param("manager_id") Long manager_id);

    @Query("SELECT p from PatientEntity p WHERE p.manager_id = :manager_id AND p.volunteer_id IS NULL " +
            "ORDER BY p.patient_id")
    public List<PatientEntity> findOrphanedPatientEntitiesByManager_id(@Param("manager_id") Long manager_id);

    @Query("SELECT p from PatientEntity p WHERE p.volunteer_id = :volunteer_id ORDER BY p.patient_id")
    public List<PatientEntity> findPatientEntitiesByVolunteer_id(@Param("volunteer_id") Long volunteer_id);
}
