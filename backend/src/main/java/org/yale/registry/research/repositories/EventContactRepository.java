package org.yale.registry.research.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.yale.registry.research.CompositeIds.EventContactId;
import org.yale.registry.research.entities.EventContactEntity;

import java.util.List;


public interface EventContactRepository extends PagingAndSortingRepository<EventContactEntity, EventContactId> {
    @Query(
            "SELECT ec FROM EventContactEntity ec WHERE ec.eventContactId.event_id = :event_id"
    )
    public List<EventContactEntity> findByEventId(Long event_id);
}
