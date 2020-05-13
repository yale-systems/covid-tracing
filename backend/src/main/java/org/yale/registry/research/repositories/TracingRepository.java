package org.yale.registry.research.repositories;

import org.locationtech.jts.geom.Point;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.yale.registry.research.entities.ContactsEntity;
import org.yale.registry.research.entities.TracingEntity;

import java.util.Date;
import java.util.List;

public interface TracingRepository extends PagingAndSortingRepository<TracingEntity, Long> {
    @Query("select t from TracingEntity t where " +
            "dwithin(transform(t.geom, 32618), transform(:point, 32618), :meters) = true " +
            "and :check_start_time between t.start_time and t.end_time")
    List<TracingEntity> findWithinDistance(@Param("point")Point point, @Param("meters") Integer meters,
                                            @Param("check_start_time") Date startTime);
}
