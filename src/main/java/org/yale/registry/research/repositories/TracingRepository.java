package org.yale.registry.research.repositories;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.yale.registry.research.entities.TracingEntity;

public interface TracingRepository extends PagingAndSortingRepository<TracingEntity, Long> {
}
