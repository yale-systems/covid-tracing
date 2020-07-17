package org.yale.registry.research.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.yale.registry.research.DTOs.ContactDTO;
import org.yale.registry.research.services.ContactService;

import java.util.List;

@RestController
@RequestMapping("/contact")
public class ContactController {
    private ContactService contactService;

    @Autowired
    public ContactController(ContactService contactService){
        this.contactService = contactService;
    }

    @CrossOrigin
    @RequestMapping(value = "/getbycontactid/{contact_id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ContactDTO getByContactId(@PathVariable Long contact_id){
        return contactService.getContactDTOById(contact_id);
    }

    @CrossOrigin
    @RequestMapping(value = "/getbypatientid/{patient_id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<ContactDTO> getByPatientId(@PathVariable Long patient_id){
        return contactService.getContactDTOByPatientId(patient_id);
    }

    @CrossOrigin
    @RequestMapping(value = "/getbyvolunteerid/{volunteer_id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<ContactDTO> getByVolunteerId(@PathVariable Long volunteer_id){
        return contactService.getContactDTOForVolunteer(volunteer_id);
    }

    @CrossOrigin
    @RequestMapping(value = "/insert", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<ContactDTO> insert(@RequestBody ContactDTO contactDTO){
        return ResponseEntity.ok(contactService.insert(contactDTO));
    }

    @CrossOrigin
    @RequestMapping(value = "/update", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<ContactDTO> update(@RequestBody ContactDTO contactDTO){
        return ResponseEntity.ok(contactService.update(contactDTO));
    }

    @CrossOrigin
    @RequestMapping(value = "/delete/{contact_id}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Long> delete(@PathVariable Long contact_id){
        contactService.delete(contact_id);
        return ResponseEntity.ok(contact_id);
    }

    @CrossOrigin
    @RequestMapping(value = "/getbyeventid/{event_id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<ContactDTO> getByEventId(@PathVariable Long event_id){
        return contactService.getContactDTOByEventId(event_id);
    }
}
