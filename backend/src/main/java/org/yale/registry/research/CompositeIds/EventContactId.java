package org.yale.registry.research.CompositeIds;

import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class EventContactId implements Serializable {
    private Long event_id;
    private Long contact_id;

    public EventContactId(){}

    public EventContactId(Long event_id, Long contact_id) {
        this.event_id = event_id;
        this.contact_id = contact_id;
    }

    public Long getEvent_id() {
        return event_id;
    }

    public void setEvent_id(Long event_id) {
        this.event_id = event_id;
    }

    public Long getContact_id() {
        return contact_id;
    }

    public void setContact_id(Long contact_id) {
        this.contact_id = contact_id;
    }

    @Override
    public boolean equals(Object o){
        if(this == o) return true;
        if(!(o instanceof EventContactId)) return false;
        EventContactId that = (EventContactId) o;
        return Objects.equals(getEvent_id(), that.getEvent_id()) &&
                Objects.equals(getContact_id(), that.getContact_id());
    }

    @Override
    public int hashCode(){
        return Objects.hash(getEvent_id(), getContact_id());
    }
}
