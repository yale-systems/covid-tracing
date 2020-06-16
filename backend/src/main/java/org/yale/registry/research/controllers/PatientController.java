package org.yale.registry.research.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.web.bind.annotation.*;
import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.DTOs.VolunteerDTO;
import org.yale.registry.research.services.PatientService;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping(value = "/patient")
public class PatientController {
    private PatientService patientService;

    @Autowired
    public PatientController(PatientService patientService){
        this.patientService = patientService;
    }

    @CrossOrigin
    @RequestMapping(value = "/getbypatientid/{patient_id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public PatientDTO getByPatientId(@PathVariable Long patient_id, HttpSession httpSession){
        return patientService.getPatientDTOById(patient_id);
    }

    @CrossOrigin
    @RequestMapping(value = "/getbymanagerid/{manager_id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<PatientDTO> getByManagerId(@PathVariable Long manager_id, HttpSession httpSession){
        return patientService.getPatientsByManagerId(manager_id);
    }

    @CrossOrigin
    @RequestMapping(value = "/getorphanedbymanagerid/{manager_id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<PatientDTO> getOrphanedByManagerId(@PathVariable Long manager_id){
        return patientService.getOrphanedPatientsByManagerId(manager_id);
    }

    @CrossOrigin
    @RequestMapping(value = "/getbyvolunteerid/{volunteer_id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<PatientDTO> getByVolunteerId(@PathVariable Long volunteer_id){
        return patientService.getPatientsByVolunteerId(volunteer_id);
    }

    @CrossOrigin
    @RequestMapping(value = "/insert", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<PatientDTO> insert(@RequestBody PatientDTO patientDTO){
        PatientDTO insertedPatientDTO = patientService.insert(patientDTO);
//        patientService.sendCreationEmail(
//                patientDTO.getName(),
//                patientDTO.getEmail(),
//                patientDTO.getUsername(),
//                patientDTO.getPassword()
//        );
        return ResponseEntity.ok(insertedPatientDTO);
    }

    @CrossOrigin
    @RequestMapping(value = "/update", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<PatientDTO> update(@RequestBody PatientDTO patientDTO){
        return ResponseEntity.ok(patientService.update(patientDTO));
    }

    @CrossOrigin
    @RequestMapping(value = "/reassignment", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<PatientDTO> reassignment(@RequestBody Map<String, Long> reassignment){
        Long patientId = reassignment.get("patient_id");
        if(patientId == null){
            return null;
        }
        Long newVolunteerId = reassignment.get("new_volunteer_id");
        return ResponseEntity.ok(patientService.reassignment(patientId, newVolunteerId));
    }

    @CrossOrigin
    @RequestMapping(value = "/delete/{patient_id}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Long> delete(@PathVariable Long patient_id){
        patientService.delete(patient_id);
        return ResponseEntity.ok(patient_id);
    }
}
