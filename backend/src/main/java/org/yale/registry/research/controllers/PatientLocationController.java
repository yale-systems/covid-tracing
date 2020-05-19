package org.yale.registry.research.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.yale.registry.research.DTOs.PatientLocationDTO;
import org.yale.registry.research.services.PatientLocationService;

import java.util.Date;
import java.util.Random;
import java.util.List;

@RestController
@RequestMapping(value = "/patient/location")
public class PatientLocationController {
    private PatientLocationService patientLocationService;

    @Autowired
    public PatientLocationController(PatientLocationService patientLocationService) {
        this.patientLocationService = patientLocationService;
    }

    @CrossOrigin
    @GetMapping(value = "/getrange", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<PatientLocationDTO> getRange(@RequestParam(defaultValue = "10") Integer range) {
        return patientLocationService.getByIDRange(range);
    }

    @CrossOrigin
    @GetMapping(value = "/getonerandom", produces = MediaType.APPLICATION_JSON_VALUE)
    public PatientLocationDTO getOneRandom() throws Exception {
        Random idGenerator = new Random();
        Long id = new Long(idGenerator.nextInt(4350) + 1);
        return patientLocationService.getResearchOpportunity(id);
    }

    @CrossOrigin
    @GetMapping(value = "/getone", produces = MediaType.APPLICATION_JSON_VALUE)
    public PatientLocationDTO getOne(@RequestParam Integer id) throws Exception {
        Long idLong = new Long(id);
        return patientLocationService.getResearchOpportunity(idLong);
    }

    @CrossOrigin
    @GetMapping(value = "/withinrange", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<PatientLocationDTO> getWithinRange(@RequestParam String latitude, @RequestParam String longitude,
                                                   @RequestParam("start_time") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
                                                           Date startTime,
                                                   @RequestParam(defaultValue = "10") Integer range) {
        Double doubleLong = Double.parseDouble(longitude);
        Double doubleLat = Double.parseDouble(latitude);
        return patientLocationService.getInRange(doubleLong, doubleLat, range, startTime);
    }

    @CrossOrigin
    @PostMapping(value = "/insert")
    public ResponseEntity<PatientLocationDTO> insert(@RequestBody PatientLocationDTO patientLocationDTO) {
        patientLocationService.insertEntity(patientLocationDTO);
        return ResponseEntity.ok().build();
    }
}

