package org.yale.registry.research.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.services.PatientService;

import java.util.List;

@RestController
@RequestMapping(value = "/patient")
public class PatientController {
    private PatientService patientService;

    @Autowired
    public PatientController(PatientService patientService){
        this.patientService = patientService;
    }

    @CrossOrigin
    @RequestMapping(value = "/getcontactbyid", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public PatientDTO getContactById(@RequestParam Long trace_id){
        return patientService.getContactDTOById(trace_id);
    }
    @CrossOrigin
    @RequestMapping(value = "/getcontactbyname", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<PatientDTO> getContactByName(@RequestParam String name){
        return patientService.getContactDTOsByName(name);
    }

}
