package org.yale.registry.research.entities;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "dummy_data")
public class TracingEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    private Integer trace_id;

    @Temporal(TemporalType.TIMESTAMP)
    private Date start_time;

    private Float latitude;

    private Float longitude;

    @Temporal(TemporalType.TIMESTAMP)
    private Date end_time;

    private Boolean confirmed;



    public Long getId() {
        return id;
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


    public void setId(Long id) {
        this.id = id;
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
