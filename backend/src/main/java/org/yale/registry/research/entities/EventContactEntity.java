package org.yale.registry.research.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.yale.registry.research.CompositeIds.EventContactId;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name = "event_contact")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EventContactEntity implements Serializable {
    @EmbeddedId
    private EventContactId eventContactId;
}
