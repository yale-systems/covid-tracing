package org.yale.registry.research.entities;

import org.yale.registry.research.CompositeIds.EventContactId;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name = "event_contact")
public class EventContactEntity implements Serializable {
    @EmbeddedId
    private EventContactId eventContactId;

    public EventContactEntity(){}

    public EventContactEntity(EventContactId eventContactId) {
        this.eventContactId = eventContactId;
    }

    public EventContactId getEventContactId() {
        return eventContactId;
    }

    public void setEventContactId(EventContactId eventContactId) {
        this.eventContactId = eventContactId;
    }
}
