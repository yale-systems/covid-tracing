package org.yale.registry.research.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.yale.registry.research.DTOs.PatientLocationDTO;
import org.yale.registry.research.entities.PatientLocationEntity;
import org.yale.registry.research.services.PatientLocationService;

import java.util.Date;
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
    @GetMapping(value = "/getbypatientid/{patient_id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<PatientLocationDTO> getByPatientId(@PathVariable Long patient_id) {
        return patientLocationService.getByPatientId(patient_id);
    }

    @CrossOrigin
    @GetMapping(value = "/getbyid/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public PatientLocationDTO getById(@PathVariable Long id){
        return patientLocationService.getPatientLocationById(id);
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
        return ResponseEntity.ok(patientLocationService.insert(patientLocationDTO));
    }

    @CrossOrigin
    @RequestMapping(value = "/update", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<PatientLocationDTO> update(@RequestBody PatientLocationDTO patientLocationDTO){
        return ResponseEntity.ok(patientLocationService.update(patientLocationDTO));
    }

    @CrossOrigin
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Long> delete(@PathVariable Long id){
        patientLocationService.delete(id);
        return ResponseEntity.ok(id);
    }

}

