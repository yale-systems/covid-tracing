package org.yale.registry.research.entities;

import org.locationtech.jts.geom.Point;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

@Entity
@Table(name = "contacts")
public class ContactsEntity {
    @Id
    @SequenceGenerator(name = "contacts_generator", sequenceName = "contacts_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "contacts_generator")
    private Long trace_id;

    private String name;

    private String email;

    private String address;

    @OneToMany(orphanRemoval = true, cascade = CascadeType.ALL)
    @JoinColumn(name="trace_id")
    private Set<TracingEntity> tracings;

    public ContactsEntity(){}

    public ContactsEntity(String name, String email, String address, Set<TracingEntity> tracings) {
        this.name = name;
        this.email = email;
        this.address = address;
        this.tracings = tracings;
    }


    public Long getTrace_id() {
        return trace_id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getAddress() {
        return address;
    }

    public Set<TracingEntity> getTracings() {
        return tracings;
    }

    public void setTrace_id(Long trace_id) {
        this.trace_id = trace_id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setTracings(Set<TracingEntity> tracings) {
        this.tracings = tracings;
    }
}
