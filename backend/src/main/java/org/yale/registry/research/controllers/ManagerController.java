package org.yale.registry.research.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.yale.registry.research.DTOs.ManagerDTO;
import org.yale.registry.research.services.ManagerService;

@RestController
@RequestMapping("/manager")
public class ManagerController {
    private ManagerService managerService;

    @Autowired
    public ManagerController(ManagerService managerService) {
        this.managerService = managerService;
    }

    @CrossOrigin
    @RequestMapping(value = "/getbymanagerid/{manager_id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ManagerDTO getByManagerId(@PathVariable Long manager_id){
        return managerService.getManagerDTOById(manager_id);
    }
}
