package org.yale.registry.research.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.entities.PatientEntity;
import org.yale.registry.research.services.PatientService;

import javax.servlet.http.HttpSession;
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
    @RequestMapping(value = "/getpatientbyid", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public PatientDTO getPatientById(@RequestParam Long patient_id, HttpSession httpSession){
        return patientService.getPatientDTOById(patient_id);
    }
    @CrossOrigin
    @RequestMapping(value = "/getpatientbyname", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<PatientDTO> getPatientByName(@RequestParam String name){
        return patientService.getPatientDTOsByName(name);
    }

}
