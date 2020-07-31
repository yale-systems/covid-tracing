package org.yale.registry.research.DTOs;

import com.bedatadriven.jackson.datatype.jts.serialization.GeometryDeserializer;
import com.bedatadriven.jackson.datatype.jts.serialization.GeometrySerializer;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.locationtech.jts.geom.Point;
import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.entities.EventEntity;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EventDTO extends RepresentationModel<EventDTO> {
    @Id
    @SequenceGenerator(
            name = "events_generator",
            sequenceName = "events_id_seq",
            allocationSize = 1
    )
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "events_generator")
    private Long event_id;

    private Long patient_id;

    @Temporal(TemporalType.TIMESTAMP)
    private Date start_time;

    @Temporal(TemporalType.TIMESTAMP)
    private Date end_time;

    private Boolean confirmed;

    private String notes;

    @JsonSerialize(using = GeometrySerializer.class)
    @JsonDeserialize(using = GeometryDeserializer.class)
    private Point geom;

    private List<Long> contact_ids;

    public EventDTO(Long patient_id, Date start_time, Date end_time,
                       Boolean confirmed, String notes, Point geom, List<Long> contact_ids) {
        this.patient_id = patient_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.confirmed = confirmed;
        this.notes = notes;
        this.geom = geom;
        this.contact_ids = contact_ids;
    }


    public EventDTO(EventEntity eventEntity){
        this.event_id = eventEntity.getEvent_id();
        this.patient_id = eventEntity.getPatient_id();
        this.start_time = eventEntity.getStart_time();
        this.end_time = eventEntity.getEnd_time();
        this.confirmed = eventEntity.getConfirmed();
        this.notes = eventEntity.getNotes();
        this.geom = eventEntity.getGeom();
    }
}