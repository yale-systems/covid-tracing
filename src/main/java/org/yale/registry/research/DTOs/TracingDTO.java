package org.yale.registry.research.DTOs;

import java.util.Date;
import java.util.Random;

public class TracingDTO {


    private Integer trace_id;

    private Date start_time;

    private Float latitude;

    private Float longitude;

    private Date end_time;

    private Boolean confirmed;

    public TracingDTO() {
    }

    public TracingDTO(Integer trace_id, Date start_time, Float latitude,
                      Float longitude, Date end_time, Boolean confirmed) {
        this.trace_id = trace_id;
        this.start_time = start_time;
        this.latitude = latitude;
        this.longitude = longitude;
        this.end_time = end_time;
        this.confirmed = confirmed;
    }

    public Integer getTrace_id() {
        return trace_id;
    }

    public Date getStart_time() {
        return start_time;
    }

    public Float getLatitude() {
        return latitude;
    }

    public Float getLongitude() {
        return longitude;
    }

    public Date getEnd_time() {
        return end_time;
    }

    public Boolean getConfirmed() {
        return confirmed;
    }

    public void setTrace_id(Integer trace_id) {
        this.trace_id = trace_id;
    }

    public void setStart_time(Date start_time) {
        this.start_time = start_time;
    }

    public void setLatitude(Float latitude) {
        this.latitude = latitude;
    }

    public void setLongitude(Float longitude) {
        this.longitude = longitude;
    }

    public void setEnd_time(Date end_time) {
        this.end_time = end_time;
    }

    public void setConfirmed(Boolean confirmed) {
        this.confirmed = confirmed;
    }
}
