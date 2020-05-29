package org.yale.registry.research.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.yale.registry.research.DTOs.ManagerDTO;
import org.yale.registry.research.DTOs.VolunteerDTO;
import org.yale.registry.research.entities.ManagerEntity;

import java.util.Optional;

public interface ManagerRepository extends PagingAndSortingRepository<ManagerEntity, Long> {
    @Query("SELECT new org.yale.registry.research.DTOs.ManagerDTO(m.manager_id, m.username, " +
            "m.password, m.name) from " +
            "ManagerEntity m WHERE m.manager_id = :manager_id")
    Optional<ManagerDTO> findManagerDTOByManager_id(@Param("manager_id") Long manager_id);
}
