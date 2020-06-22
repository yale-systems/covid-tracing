package org.yale.registry.research.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.yale.registry.research.DTOs.EventDTO;
import org.yale.registry.research.services.EventContactService;
import org.yale.registry.research.services.EventService;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping(value = "/event")
public class EventController {
    private EventService eventService;
    private EventContactService eventContactService;

    @Autowired
    public EventController(
            EventService eventService,
            EventContactService eventContactService
    ) {
        this.eventService = eventService;
        this.eventContactService = eventContactService;
    }

    @CrossOrigin
    @GetMapping(value = "/getbypatientid/{patient_id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<EventDTO> getByPatientId(@PathVariable Long patient_id) {
        return eventService.getByPatientId(patient_id);
    }

    @CrossOrigin
    @GetMapping(value = "/getbyid/{event_id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public EventDTO getByEventId(@PathVariable Long event_id){
        return eventService.getByEventId(event_id);
    }

    @CrossOrigin
    @GetMapping(value = "/withinrange", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<EventDTO> getWithinRange(@RequestParam String latitude, @RequestParam String longitude,
                                         @RequestParam("start_time") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
                                                           Date startTime,
                                         @RequestParam(defaultValue = "10") Integer range) {
        Double doubleLong = Double.parseDouble(longitude);
        Double doubleLat = Double.parseDouble(latitude);
        return eventService.getInRange(doubleLong, doubleLat, range, startTime);
    }

    @CrossOrigin
    @PostMapping(value = "/insert")
    public ResponseEntity<EventDTO> insert(@RequestBody EventDTO eventDTO) {
        EventDTO finalEventDTO = eventService.insert(eventDTO);
        if(eventDTO.getContact_ids() != null){
            eventContactService.insertEventContacts(eventDTO.getEvent_id(), eventDTO.getContact_ids());
        }
        return ResponseEntity.ok(finalEventDTO);
    }

    @CrossOrigin
    @RequestMapping(value = "/update", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<EventDTO> update(@RequestBody EventDTO eventDTO){
        EventDTO finalEventDTO = eventService.update(eventDTO);
        if(eventDTO.getContact_ids() != null){
            eventContactService.updateEventContacts(eventDTO.getEvent_id(), eventDTO.getContact_ids());
        }
        return ResponseEntity.ok(finalEventDTO);
    }

    @CrossOrigin
    @RequestMapping(value = "/delete/{event_id}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Long> delete(@PathVariable Long event_id){
        eventService.delete(event_id);
        return ResponseEntity.ok(event_id);
    }

}

