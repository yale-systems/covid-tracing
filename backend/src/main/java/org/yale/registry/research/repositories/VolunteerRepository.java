package org.yale.registry.research.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.yale.registry.research.DTOs.VolunteerDTO;
import org.yale.registry.research.entities.VolunteerEntity;

import java.util.List;
import java.util.Optional;

public interface VolunteerRepository extends PagingAndSortingRepository<VolunteerEntity, Long> {
    @Query("SELECT v from VolunteerEntity v WHERE v.volunteer_id = :volunteer_id")
    public Optional<VolunteerEntity> findVolunteerEntityByVolunteer_id(@Param("volunteer_id") Long volunteer_id);

    @Query("SELECT v from VolunteerEntity v WHERE v.manager_id = :manager_id")
    public List<VolunteerEntity> findVolunteerEntitiesByManager_id(@Param("manager_id") Long manager_id);
}
