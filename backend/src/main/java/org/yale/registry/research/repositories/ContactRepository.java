package org.yale.registry.research.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.yale.registry.research.DTOs.ContactDTO;
import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.entities.ContactEntity;
import org.yale.registry.research.entities.PatientEntity;

import java.util.List;
import java.util.Optional;

public interface ContactRepository extends PagingAndSortingRepository<ContactEntity, Long> {

    @Query("SELECT new org.yale.registry.research.DTOs.ContactDTO(c.contact_id, c.first_name, c.last_name, " +
            "c.email, c.phone_number, c.age_group, c.household, c.contact_type, c.times_called, c.contact_call_status, " +
            "c.contact_date, c.update_date, c.relationship, c.language, c.symptomatic, c.self_isolate, c.notes, " +
            "c.isolated_from_patient, c.healthcare_worker, c.patient_id) " +
            "from ContactEntity c WHERE c.contact_id = :contact_id")
    public Optional<ContactDTO> findContactDTOByContact_id(@Param("contact_id") Long contact_id);

    @Query("SELECT new org.yale.registry.research.DTOs.ContactDTO(c.contact_id, c.first_name, c.last_name, " +
            "c.email, c.phone_number, c.age_group, c.household, c.contact_type, c.times_called, c.contact_call_status, " +
            "c.contact_date, c.update_date, c.relationship, c.language, c.symptomatic, c.self_isolate, c.notes, " +
            "c.isolated_from_patient, c.healthcare_worker, c.patient_id) " +
            "from ContactEntity c WHERE c.patient_id = :patient_id")
    public List<ContactDTO> findContactDTOsByPatient_id(@Param("patient_id") Long patient_id);

    @Query("SELECT new org.yale.registry.research.DTOs.ContactDTO(c.contact_id, c.first_name, c.last_name, " +
            "c.email, c.phone_number, c.age_group, c.household, c.contact_type, c.times_called, c.contact_call_status, " +
            "c.contact_date, c.update_date, c.relationship, c.language, c.symptomatic, c.self_isolate, c.notes, " +
            "c.isolated_from_patient, c.healthcare_worker, c.patient_id) " +
            "from ContactEntity c, EventContactEntity ec WHERE " +
            "ec.eventContactId.event_id = :event_id AND ec.eventContactId.contact_id = c.contact_id")
    public List<ContactDTO> findContactDTOsByEventId(@Param("event_id") Long event_id);
}
