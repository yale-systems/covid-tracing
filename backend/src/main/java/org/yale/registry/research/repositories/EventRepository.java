package org.yale.registry.research.repositories;

import org.locationtech.jts.geom.Point;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.yale.registry.research.entities.EventEntity;

import java.util.Date;
import java.util.List;

public interface EventRepository extends PagingAndSortingRepository<EventEntity, Long> {
    @Query("select t from EventEntity t where " +
            "dwithin(transform(t.geom, 32618), transform(:point, 32618), :meters) = true " +
            "and :check_start_time between t.start_time and t.end_time")
    public List<EventEntity> findWithinDistance(@Param("point")Point point, @Param("meters") Integer meters,
                                                @Param("check_start_time") Date startTime);

    @Query("SELECT p FROM EventEntity p where p.patient_id = :patient_id")
    public List<EventEntity> findEventEntitiesByPatientId(@Param("patient_id") Long patient_id);

    @Query("DELETE FROM EventEntity p WHERE p.patient_id = :patient_id")
    @Modifying
    public void deleteByPatientId(@Param("patient_id") Long patient_id);

}
