package org.yale.registry.research.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.yale.registry.research.DTOs.TracingDTO;
import org.yale.registry.research.services.TracingService;

import java.util.Date;
import java.util.Random;
import java.util.List;

@RestController
public class TracingController {
    private TracingService tracingService;


    @Autowired
    public TracingController(TracingService tracingService){
        this.tracingService = tracingService;
    }

    @CrossOrigin
    @RequestMapping(value = "/getrange", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<TracingDTO> getRange(@RequestParam(defaultValue = "10") Integer range) {
        return tracingService.getRange(range);
    }

    @CrossOrigin
    @RequestMapping(value = "/getonerandom", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public TracingDTO getOneRandom() throws Exception{
        Random idGenerator = new Random();
        Long id = new Long(idGenerator.nextInt(9000) + 1);
        return tracingService.getResearchOpportunity(id);
    }


    @RequestMapping(value = "/getone", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public TracingDTO getOne(@RequestParam Integer id) throws Exception{
        Long idLong = new Long(id);
        return tracingService.getResearchOpportunity(idLong);
    }

    @CrossOrigin
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    ResponseEntity<TracingDTO> insert(@RequestBody TracingDTO tracingDTO){
        tracingService.insertEntity(tracingDTO);
        return ResponseEntity.ok().build();
    }

    // @RequestMapping(value = "/makeAjitter", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    // public TracingDTO makeAjitter() throws Exception{
    //     TracingDTO jittered = new TracingDTO(10000, new Date(), new Float(100), new Float(200), new Date(), false);
    //     tracingService.insertEntity(jittered);
    //     ResponseEntity.ok().build();
    //     return jittered;
    // }

//    @RequestMapping(value = "/edit", method = RequestMethod.GET)
//    public ModelAndView edit(@RequestParam(required = false) Long id) throws Exception {
//        ModelAndView mv = new ModelAndView("edit");
//        TracingDTO dto;
//        if(id != null) {
//            dto = researchService.getResearchOpportunity(id);
//            mv.addObject("dto", dto);
//        }
//        return mv;
//    }

//    @RequestMapping(value = "/change", method = RequestMethod.POST)
//    public ResponseEntity<TracingEntity> change(@RequestBody TracingEntity researchEntity){
//        researchService.insertOrUpdateResearchEntity(researchEntity);
//        return ResponseEntity.ok().build();
//    }

//    @RequestMapping(value = "/delete", method = RequestMethod.DELETE)
//    public ResponseEntity<Integer> delete(@RequestParam Long id){
//        researchService.deleteResearchEntityById(id);
//        return ResponseEntity.ok().build();
//    }
}
