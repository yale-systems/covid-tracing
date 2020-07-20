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

    @Query("SELECT c from ContactEntity c WHERE c.contact_id = :contact_id")
    public Optional<ContactEntity> findContactEntityByContact_id(@Param("contact_id") Long contact_id);

    @Query("SELECT c from ContactEntity c WHERE c.patient_id = :patient_id ORDER BY c.contact_id")
    public List<ContactEntity> findContactEntitiesByPatient_id(@Param("patient_id") Long patient_id);

    @Query("SELECT c from ContactEntity c, EventContactEntity ec WHERE " +
            "ec.eventContactId.event_id = :event_id AND ec.eventContactId.contact_id = c.contact_id " +
            "ORDER BY c.contact_id")
    public List<ContactEntity> findContactEntitiesByEventId(@Param("event_id") Long event_id);

    @Query("SELECT c FROM ContactEntity c, PatientEntity p WHERE " +
            "p.volunteer_id = :volunteer_id AND c.patient_id = p.patient_id ORDER BY c.contact_id")
    public List<ContactEntity> findContactEntitiesForVolunteer(@Param("volunteer_id") Long volunteer_id);
}
