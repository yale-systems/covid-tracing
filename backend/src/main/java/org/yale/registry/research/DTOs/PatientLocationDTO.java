package org.yale.registry.research.DTOs;

import com.bedatadriven.jackson.datatype.jts.serialization.GeometryDeserializer;
import com.bedatadriven.jackson.datatype.jts.serialization.GeometrySerializer;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import org.locationtech.jts.geom.Point;
import org.springframework.hateoas.RepresentationModel;

import java.util.Date;

public class PatientLocationDTO extends RepresentationModel<PatientLocationDTO> {

    private Long id;

    private Date start_time;

    private Date end_time;

    private Boolean confirmed;

    private Long patient_id;

    @JsonSerialize(using = GeometrySerializer.class)
    @JsonDeserialize(using = GeometryDeserializer.class)
    private Point geom;

    public PatientLocationDTO() {
    }

    public PatientLocationDTO(Long id, Date start_time,
                              Date end_time, Boolean confirmed,
                              Point geom, Long patient_id) {
        this.id = id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.confirmed = confirmed;
        this.geom = geom;
        this.patient_id = patient_id;
    }

    public Long getId() {
        return id;
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

    public void setId(Long id) {
        this.id = id;
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
}

