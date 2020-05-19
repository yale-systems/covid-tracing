package org.yale.registry.research.entities;

import org.locationtech.jts.geom.Point;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "patient_locations")
public class PatientLocationEntity {
    @Id
    @SequenceGenerator(name = "patient_locations_generator", sequenceName = "patient_locations_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "patient_locations_generator")
    private Long id;

    private Long patient_id;

    @Temporal(TemporalType.TIMESTAMP)
    private Date start_time;

    @Temporal(TemporalType.TIMESTAMP)
    private Date end_time;

    private Boolean confirmed;

    private Point geom;

    public PatientLocationEntity(){}

    public PatientLocationEntity(Long patient_id, Date start_time, Date end_time, Boolean confirmed, Point geom) {
        this.patient_id = patient_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.confirmed = confirmed;
        this.geom = geom;
    }

    public Long getId() {
        return id;
    }

    public Long getPatient_id() {
        return patient_id;
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

    public Point getGeom(){
        return geom;
    }


    public void setId(Long id) {
        this.id = id;
    }

    public void setPatient_id(Long trace_id) {
        this.patient_id = trace_id;
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

}
