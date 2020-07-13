package org.yale.registry.research.entities;

import org.locationtech.jts.geom.Point;
import org.yale.registry.research.DTOs.EventDTO;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "events")
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


    public EventEntity(){}

    public EventEntity(Long event_id, Long patient_id, Date start_time,
                       Date end_time, Boolean confirmed, String notes,
                       Point geom) {
        this.event_id = event_id;
        this.patient_id = patient_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.confirmed = confirmed;
        this.notes = notes;
        this.geom = geom;
    }

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

    public Long getEvent_id() {
        return event_id;
    }

    public void setEvent_id(Long event_id) {
        this.event_id = event_id;
    }

    public Long getPatient_id() {
        return patient_id;
    }

    public void setPatient_id(Long patient_id) {
        this.patient_id = patient_id;
    }

    public Date getStart_time() {
        return start_time;
    }

    public void setStart_time(Date start_time) {
        this.start_time = start_time;
    }

    public Date getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Date end_time) {
        this.end_time = end_time;
    }

    public Boolean getConfirmed() {
        return confirmed;
    }

    public void setConfirmed(Boolean confirmed) {
        this.confirmed = confirmed;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Point getGeom() {
        return geom;
    }

    public void setGeom(Point geom) {
        this.geom = geom;
    }
}
