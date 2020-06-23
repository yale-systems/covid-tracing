package org.yale.registry.research.entities;

import org.locationtech.jts.geom.Point;

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

    @Temporal(TemporalType.TIMESTAMP)
    private Date start_time;

    @Temporal(TemporalType.TIMESTAMP)
    private Date end_time;

    private Boolean confirmed;

    private Point geom;

    private Long patient_id;


    public EventEntity(){}

    public EventEntity(Long event_id, Date start_time, Date end_time,
                       Boolean confirmed, Point geom,
                       Long patient_id) {
        this.event_id = event_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.confirmed = confirmed;
        this.geom = geom;
        this.patient_id = patient_id;
    }

    public EventEntity(Date start_time, Date end_time,
                       Boolean confirmed, Point geom,
                       Long patient_id) {
        this.start_time = start_time;
        this.end_time = end_time;
        this.confirmed = confirmed;
        this.geom = geom;
        this.patient_id = patient_id;
    }

    public Long getEvent_id() {
        return event_id;
    }

    public void setEvent_id(Long id) {
        this.event_id = id;
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

    public Point getGeom() {
        return geom;
    }

    public void setGeom(Point geom) {
        this.geom = geom;
    }

    public Long getPatient_id() {
        return patient_id;
    }

    public void setPatient_id(Long patient_id) {
        this.patient_id = patient_id;
    }
}
