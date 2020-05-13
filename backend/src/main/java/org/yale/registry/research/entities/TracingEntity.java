package org.yale.registry.research.entities;

import org.locationtech.jts.geom.Point;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "dummy_data")
public class TracingEntity {
    @Id
    @SequenceGenerator(name = "tracing_generator", sequenceName = "dummy_data_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "tracing_generator")
    private Long id;

    private Long trace_id;

    @Temporal(TemporalType.TIMESTAMP)
    private Date start_time;

    @Temporal(TemporalType.TIMESTAMP)
    private Date end_time;

    private Boolean confirmed;

    private Point geom;

    public TracingEntity(){}

    public TracingEntity(Long trace_id, Date start_time, Date end_time, Boolean confirmed, Point geom) {
        this.trace_id = trace_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.confirmed = confirmed;
        this.geom = geom;
    }

    public Long getId() {
        return id;
    }

    public Long getTrace_id() {
        return trace_id;
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

    public void setTrace_id(Long trace_id) {
        this.trace_id = trace_id;
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
