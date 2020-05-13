package org.yale.registry.research.utilities;

import org.yale.registry.research.DTOs.ContactsDTO;
import org.yale.registry.research.DTOs.TracingDTO;
import org.yale.registry.research.entities.ContactsEntity;
import org.yale.registry.research.entities.TracingEntity;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class DTOUtility {

    public static List<TracingDTO> tracingDTOAggregator(List<TracingEntity> tracingEntityList){
        List<TracingDTO> dtoAggregate = new ArrayList<>();
        for(TracingEntity cur: tracingEntityList){
            dtoAggregate.add(tracingEntityToDTO(cur));
        }
        return dtoAggregate;
    }

    public static TracingDTO tracingEntityToDTO(TracingEntity tracingEntity){
        return new TracingDTO(tracingEntity.getTrace_id(), tracingEntity.getStart_time(),
                tracingEntity.getEnd_time(), tracingEntity.isConfirmed(), tracingEntity.getGeom());
    }

    public static TracingEntity tracingDTOToEntity(TracingDTO tracingDTO){
        return new TracingEntity(tracingDTO.getTrace_id(), tracingDTO.getStart_time(),
                tracingDTO.getEnd_time(), tracingDTO.isConfirmed(), tracingDTO.getGeom());
    }

    public static ContactsDTO contactsEntityToDTO(ContactsEntity contactsEntity){
        List<TracingEntity> tracingEntities = new ArrayList<>(contactsEntity.getTracings());
        List<TracingDTO> tracingDTOS = tracingDTOAggregator(tracingEntities);
        tracingDTOS.sort(Comparator.comparing(TracingDTO::getStart_time));
        return new ContactsDTO(contactsEntity.getName(), contactsEntity.getEmail(),
                contactsEntity.getAddress(), tracingDTOS);
    }

    public static List<ContactsDTO> contactsDTOAggregator(List<ContactsEntity> contactsEntityList){
        List<ContactsDTO> dtoAggregate = new ArrayList<>();
        for(ContactsEntity cur: contactsEntityList){
            dtoAggregate.add(contactsEntityToDTO(cur));
        }
        return dtoAggregate;
    }
}
