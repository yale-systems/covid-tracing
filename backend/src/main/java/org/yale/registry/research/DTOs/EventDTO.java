package org.yale.registry.research.DTOs;

import com.bedatadriven.jackson.datatype.jts.serialization.GeometryDeserializer;
import com.bedatadriven.jackson.datatype.jts.serialization.GeometrySerializer;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import org.locationtech.jts.geom.Point;
import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.entities.EventEntity;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

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

    public EventDTO(){}

    public EventDTO(Long event_id, Long patient_id, Date start_time,
                       Date end_time, Boolean confirmed, String notes,
                       Point geom, List<Long> contact_ids) {
        this.event_id = event_id;
        this.patient_id = patient_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.confirmed = confirmed;
        this.notes = notes;
        this.geom = geom;
        this.contact_ids = contact_ids;
    }

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

    public List<Long> getContact_ids() {
        return contact_ids;
    }

    public void setContact_ids(List<Long> contact_ids) {
        this.contact_ids = contact_ids;
    }
}