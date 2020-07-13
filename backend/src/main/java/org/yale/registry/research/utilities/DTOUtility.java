package org.yale.registry.research.utilities;

import org.yale.registry.research.DTOs.EventDTO;
import org.yale.registry.research.entities.EventEntity;

import java.util.ArrayList;
import java.util.List;

public class DTOUtility {

    public static List<EventDTO> eventDTOAggregator(List<EventEntity> eventEntityList){
        List<EventDTO> dtoAggregate = new ArrayList<>();
        for(EventEntity cur: eventEntityList){
            dtoAggregate.add(new EventDTO(cur));
        }
        return dtoAggregate;
    }
//
//    public static EventDTO eventEntityToDTO(EventEntity eventEntity){
//        return new EventDTO(
//                eventEntity.getEvent_id(), eventEntity.getStart_time(),
//                eventEntity.getEnd_time(), eventEntity.getConfirmed(),
//                eventEntity.getGeom(), eventEntity.getPatient_id()
//        );
//    }
//
//    public static EventEntity eventDTOToEntity(EventDTO eventDTO){
//        return new EventEntity(
//                eventDTO.getStart_time(), eventDTO.getEnd_time(),
//                eventDTO.isConfirmed(), eventDTO.getGeom(),
//                eventDTO.getPatient_id()
//                );
//    }

}
