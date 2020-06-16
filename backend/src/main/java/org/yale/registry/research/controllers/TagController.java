package org.yale.registry.research.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.yale.registry.research.DTOs.TagDTO;
import org.yale.registry.research.DTOs.VolunteerDTO;
import org.yale.registry.research.services.TagService;

@RestController
@RequestMapping("/tag")
public class TagController {
    private TagService tagService;

    @Autowired
    public TagController(TagService tagService) {
        this.tagService = tagService;
    }

    @CrossOrigin
    @RequestMapping(value = "/getbytagid/{tag_id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public TagDTO getByTagId(@PathVariable Long tag_id){
        return tagService.getTagDTOById(tag_id);
    }

    @CrossOrigin
    @RequestMapping(value = "/insert", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<TagDTO> insert(@RequestBody TagDTO tagDTO){
        return ResponseEntity.ok(tagService.insert(tagDTO));
    }

}
