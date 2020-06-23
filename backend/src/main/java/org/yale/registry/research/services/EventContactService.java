package org.yale.registry.research.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yale.registry.research.CompositeIds.EventContactId;
import org.yale.registry.research.entities.EventContactEntity;
import org.yale.registry.research.repositories.EventContactRepository;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class EventContactService {
    private EventContactRepository eventContactRepository;

    @Autowired
    public EventContactService(EventContactRepository eventContactRepository){
        this.eventContactRepository = eventContactRepository;
    }

    public void insertEventContacts(Long event_id, List<Long> contact_ids){
        List<EventContactEntity> eventContactEntities = new ArrayList<>();
        for(Long contact_id: contact_ids){
            eventContactEntities.add(new EventContactEntity(new EventContactId(event_id, contact_id)));
        }
        eventContactRepository.saveAll(eventContactEntities);
    }
    public void updateEventContacts(Long event_id, List<Long> contact_ids){
        List<EventContactEntity> eventContactEntities = eventContactRepository.findByEventId(event_id);
        List<EventContactEntity> toDelete = new ArrayList<>();
        for(EventContactEntity eventContactEntity: eventContactEntities){
            boolean delete = true;
            for(Long contact_id: contact_ids){
                if(eventContactEntity.getEventContactId().getEvent_id().equals(event_id) &&
                        eventContactEntity.getEventContactId().getContact_id().equals(contact_id)){
                    delete = false;
                    break;
                }
            }
            if(delete = true){
                toDelete.add(eventContactEntity);
            }
        }
        eventContactRepository.deleteAll(toDelete);
        insertEventContacts(event_id, contact_ids);
    }
}
