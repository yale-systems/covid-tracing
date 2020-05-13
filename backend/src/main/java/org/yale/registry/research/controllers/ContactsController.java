package org.yale.registry.research.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.yale.registry.research.DTOs.ContactsDTO;
import org.yale.registry.research.services.ContactsService;

import java.util.List;

@RestController
public class ContactsController {
    private ContactsService contactsService;

    @Autowired
    public ContactsController(ContactsService contactsService){
        this.contactsService = contactsService;
    }

    @CrossOrigin
    @RequestMapping(value = "/getcontactbyid", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ContactsDTO getContactById(@RequestParam Long trace_id){
        return contactsService.getContactDTOById(trace_id);
    }
    @CrossOrigin
    @RequestMapping(value = "/getcontactbyname", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<ContactsDTO> getContactByName(@RequestParam String name){
        return contactsService.getContactDTOsByName(name);
    }

}
