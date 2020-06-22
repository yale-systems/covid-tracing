package org.yale.registry.research.services;

import org.locationtech.jts.geom.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.EventDTO;
import org.yale.registry.research.entities.EventEntity;
import org.yale.registry.research.repositories.EventRepository;
import org.yale.registry.research.utilities.DTOUtility;
import org.yale.registry.research.utilities.RESTfulUtility;

import java.util.*;

@Service
public class EventService {
    private EventRepository eventRepository;
    private GeometryFactory geometryFactory;
    public static final int MAX_RANGE = 9000;

    @Autowired
    public EventService(EventRepository eventRepository, GeometryFactory geometryFactory){
        this.eventRepository = eventRepository;
        this.geometryFactory = geometryFactory;
    }

    public List<EventDTO> getInRange(Double longitude, Double latitude,
                                     Integer range, Date startTime){
        Point point = longLatToPoint(longitude, latitude);
        List<EventEntity> withinDistance = eventRepository.findWithinDistance(point, range, startTime);
        return DTOUtility.eventDTOAggregator(withinDistance);
    }

    public EventDTO getByEventId(Long id){
        Optional<EventEntity> optionalEventEntity = eventRepository.findById(id);
        EventDTO eventDTO =
                optionalEventEntity.map(DTOUtility::eventEntityToDTO).
                        orElse(null);
        if(eventDTO != null){
            RESTfulUtility.addRestToEventDTO(eventDTO);
        }
        return eventDTO;
    }

    public List<EventDTO> getByPatientId(Long patient_id){
        List<EventEntity> eventEntities =
                eventRepository.findEventEntitiesByPatientId(patient_id);
        List<EventDTO> eventDTOS =
                DTOUtility.eventDTOAggregator(eventEntities);
        RESTfulUtility.addRestToEventDTOs(eventDTOS);
        return eventDTOS;
    }

    public EventDTO insert(EventDTO eventDTO){
        EventEntity eventEntity = DTOUtility.eventDTOToEntity(eventDTO);
        eventRepository.save(eventEntity);
        EventDTO returnEventDTO = new EventDTO(eventEntity);
        RESTfulUtility.addRestToEventDTO(returnEventDTO);
        return returnEventDTO;
    }

    public EventDTO update(EventDTO eventDTO){
        Optional<EventEntity> optionalEventEntity =
                eventRepository.findById(eventDTO.getEvent_id());
        if(optionalEventEntity.isPresent()){
            EventEntity eventEntity = optionalEventEntity.get();
            if(eventDTO.getStart_time() != null){
                eventEntity.setStart_time(eventDTO.getStart_time());
            }
            if(eventDTO.getEnd_time() != null){
                eventEntity.setEnd_time(eventDTO.getEnd_time());
            }
            if(eventDTO.isConfirmed() != null){
                eventEntity.setConfirmed(eventDTO.isConfirmed());
            }
            if(eventDTO.getGeom() != null){
                eventEntity.setGeom(eventDTO.getGeom());
            }
            if(eventDTO.getPatient_id() != null){
                eventEntity.setPatient_id(eventDTO.getPatient_id());
            }
            eventRepository.save(eventEntity);
            EventDTO returnEventDTO = new EventDTO(eventEntity);
            RESTfulUtility.addRestToEventDTO(returnEventDTO);
            return returnEventDTO;
        }
        return null;
    }

    public void delete(Long id){
        eventRepository.deleteById(id);
    }

    private Point longLatToPoint(Double longitude, Double latitude){
        Coordinate coordinate = new Coordinate(longitude, latitude);
        return geometryFactory.createPoint(coordinate);
    }

    private Float jitterLat(Float latitude){
        Random rand = new Random();
        return new Float((((rand.nextFloat() * 2 - 1) / 100.0) + latitude));
    }

    private Float jitterLong(Float longitude){
        Random rand = new Random();
        return new Float((((rand.nextFloat() * 2 - 1) / 500.0) + longitude));
    }
}
