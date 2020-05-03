package org.yale.registry.research.entities;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "dummy_data")
public class TracingEntity {
    @Id
    @SequenceGenerator(name = "tracing_generator", sequenceName = "dummy_data_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "tracing_generator")
    private Integer id;

    private Integer trace_id;

    @Temporal(TemporalType.TIMESTAMP)
    private Date start_time;

    private Float latitude;

    private Float longitude;

    @Temporal(TemporalType.TIMESTAMP)
    private Date end_time;

    private Boolean confirmed;

    public TracingEntity(){}

    public TracingEntity(Integer trace_id, Date start_time, Float latitude, Float longitude, Date end_time, Boolean confirmed) {
        this.trace_id = trace_id;
        this.start_time = start_time;
        this.latitude = latitude;
        this.longitude = longitude;
        this.end_time = end_time;
        this.confirmed = confirmed;
    }

    public Integer getId() {
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


    public void setId(Integer id) {
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
