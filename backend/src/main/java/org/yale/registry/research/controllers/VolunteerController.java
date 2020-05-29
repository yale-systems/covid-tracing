package org.yale.registry.research.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.DTOs.VolunteerDTO;
import org.yale.registry.research.services.VolunteerService;

import java.util.List;

@RestController
@RequestMapping("/volunteer")
public class VolunteerController {
    private VolunteerService volunteerService;

    @Autowired
    public VolunteerController(VolunteerService volunteerService) {
        this.volunteerService = volunteerService;
    }

    @CrossOrigin
    @RequestMapping(value = "/getbyvolunteerid/{volunteer_id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public VolunteerDTO getByVolunteerId(@PathVariable Long volunteer_id){
        return volunteerService.getVolunteerDTOById(volunteer_id);
    }

    @CrossOrigin
    @RequestMapping(value = "/getbymanagerid/{manager_id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<VolunteerDTO> getByManagerId(@PathVariable Long manager_id){
        return volunteerService.getVolunteersByManagerId(manager_id);
    }

    @CrossOrigin
    @RequestMapping(value = "/insert", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<VolunteerDTO> insert(@RequestBody VolunteerDTO volunteerDTO){
        volunteerService.insert(volunteerDTO);
        return ResponseEntity.ok().build();
    }

    @CrossOrigin
    @RequestMapping(value = "/update", method = RequestMethod.PUT, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<PatientDTO> update(@RequestBody VolunteerDTO volunteerDTO){
        volunteerService.update(volunteerDTO);
        return ResponseEntity.ok().build();
    }

    @CrossOrigin
    @RequestMapping(value = "delete/{volunteer_id}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Long> delete(@PathVariable Long volunteer_id){
        volunteerService.delete(volunteer_id);
        return ResponseEntity.ok().build();
    }
}
