package org.yale.registry.research.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.locationtech.jts.geom.Point;
import org.yale.registry.research.DTOs.EventDTO;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "events")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EventEntity implements Serializable {
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

    private Point geom;


    public EventEntity(Long patient_id, Date start_time, Date end_time,
                       Boolean confirmed, String notes, Point geom) {
        this.patient_id = patient_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.confirmed = confirmed;
        this.notes = notes;
        this.geom = geom;
    }

    public EventEntity(EventDTO eventDTO){
        this.patient_id = eventDTO.getPatient_id();
        this.start_time = eventDTO.getStart_time();
        this.end_time = eventDTO.getEnd_time();
        this.confirmed = eventDTO.getConfirmed();
        this.notes = eventDTO.getNotes();
        this.geom = eventDTO.getGeom();
    }

    public void update(EventDTO eventDTO){
        this.start_time = eventDTO.getStart_time();
        this.end_time = eventDTO.getEnd_time();
        this.confirmed = eventDTO.getConfirmed();
        this.notes = eventDTO.getNotes();
        this.geom = eventDTO.getGeom();
    }
}
