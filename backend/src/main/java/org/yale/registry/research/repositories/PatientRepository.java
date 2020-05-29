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
    @Query("SELECT new org.yale.registry.research.DTOs.PatientDTO(p.patient_id, p.username, " +
            "p.password, p.name, p.email, p.manager_id, p.volunteer_id) from " +
            "PatientEntity p WHERE p.patient_id = :patient_id")
    public Optional<PatientDTO> findPatientDTOByPatient_id(@Param("patient_id") Long patient_id);

    @Query("SELECT new org.yale.registry.research.DTOs.PatientDTO(p.patient_id, p.username, " +
            "p.password, p.name, p.email, p.manager_id, p.volunteer_id) from " +
            "PatientEntity p WHERE p.manager_id = :manager_id")
    public List<PatientDTO> findPatientDTOsByManager_id(@Param("manager_id") Long manager_id);

    @Query("SELECT new org.yale.registry.research.DTOs.PatientDTO(p.patient_id, p.username, " +
            "p.password, p.name, p.email, p.manager_id, p.volunteer_id) from " +
            "PatientEntity p WHERE p.manager_id = :manager_id AND p.volunteer_id IS NULL")
    public List<PatientDTO> findOrphanedPatientDTOsByManager_id(@Param("manager_id") Long manager_id);

    @Query("SELECT p from PatientEntity p WHERE p.volunteer_id = :volunteer_id")
    public List<PatientEntity> findPatientEntitiesByVolunteer_id(@Param("volunteer_id") Long volunteer_id);

    @Query("SELECT new org.yale.registry.research.DTOs.PatientDTO(p.patient_id, p.username, " +
            "p.password, p.name, p.email, p.manager_id, p.volunteer_id) from " +
            "PatientEntity p WHERE p.volunteer_id = :volunteer_id")
    public List<PatientDTO> findPatientDTOsByVolunteer_id(@Param("volunteer_id") Long volunteer_id);
}
