package org.yale.registry.research.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.yale.registry.research.DTOs.TagDTO;
import org.yale.registry.research.entities.TagEntity;

import java.util.Optional;

public interface TagRepository extends PagingAndSortingRepository<TagEntity, Long> {
    @Query("SELECT new org.yale.registry.research.DTOs.TagDTO(t.tag_id, t.mac_address, " +
            "t.info, t.worst_case_rssi, t.flags, t.minutes_of_appr_contact) FROM TagEntity t " +
            "WHERE t.tag_id = :tag_id")
    public Optional<TagDTO> findTagDTOByTag_id(@Param("tag_id") Long tag_id);
}
