package org.yale.registry.research.DTOs;

import com.bedatadriven.jackson.datatype.jts.serialization.GeometryDeserializer;
import com.bedatadriven.jackson.datatype.jts.serialization.GeometrySerializer;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import org.locationtech.jts.geom.Point;
import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.entities.EventEntity;

import java.util.Date;
import java.util.List;

public class EventDTO extends RepresentationModel<EventDTO> {

    private Long event_id;

    private Date start_time;

    private Date end_time;

    private Boolean confirmed;

    private Long patient_id;

    @JsonSerialize(using = GeometrySerializer.class)
    @JsonDeserialize(using = GeometryDeserializer.class)
    private Point geom;

    private List<Long> contact_ids;

    public EventDTO() {
    }

    public EventDTO(Long event_id, Date start_time,
                    Date end_time, Boolean confirmed,
                    Point geom, Long patient_id) {
        this.event_id = event_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.confirmed = confirmed;
        this.geom = geom;
        this.patient_id = patient_id;
    }

    public EventDTO(EventEntity eventEntity) {
        this.event_id = eventEntity.getEvent_id();
        this.start_time = eventEntity.getStart_time();
        this.end_time = eventEntity.getEnd_time();
        this.confirmed = eventEntity.getConfirmed();
        this.geom = eventEntity.getGeom();
        this.patient_id = eventEntity.getPatient_id();
    }

    public EventDTO(Long event_id, Date start_time, Date end_time, Boolean confirmed, Long patient_id, Point geom, List<Long> contact_ids) {
        this.event_id = event_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.confirmed = confirmed;
        this.patient_id = patient_id;
        this.geom = geom;
        this.contact_ids = contact_ids;
    }

    public Long getEvent_id() {
        return event_id;
    }

    public Date getStart_time() {
        return start_time;
    }

    public Date getEnd_time() {
        return end_time;
    }

    public Boolean isConfirmed() {
        return confirmed;
    }

    public Point getGeom() {
        return geom;
    }

    public Long getPatient_id() {
        return patient_id;
    }

    public void setEvent_id(Long event_id) {
        this.event_id = event_id;
    }

    public void setStart_time(Date start_time) {
        this.start_time = start_time;
    }

    public void setEnd_time(Date end_time) {
        this.end_time = end_time;
    }

    public void setConfirmed(Boolean confirmed) {
        this.confirmed = confirmed;
    }

    public void setGeom(Point geom){
        this.geom = geom;
    }

    public void setPatient_id(Long patient_id) {
        this.patient_id = patient_id;
    }

    public List<Long> getContact_ids() {
        return contact_ids;
    }

    public void setContact_ids(List<Long> contact_ids) {
        this.contact_ids = contact_ids;
    }
}

