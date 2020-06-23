package org.yale.registry.research.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.DTOs.TagDTO;
import org.yale.registry.research.entities.TagEntity;
import org.yale.registry.research.repositories.TagRepository;
import org.yale.registry.research.utilities.RESTfulUtility;

import javax.transaction.Transactional;
import java.util.Optional;

@Service
@Transactional
public class TagService {
    private TagRepository tagRepository;

    @Autowired
    public TagService(TagRepository tagRepository){
        this.tagRepository = tagRepository;
    }

    public TagDTO getTagDTOById(Long tag_id){
        Optional<TagDTO> optionalTagDTO = tagRepository.findTagDTOByTag_id(tag_id);
        return optionalTagDTO.orElse(null);
    }

    public TagDTO insert(TagDTO tagDTO){
        TagEntity tagEntity = new TagEntity(
                tagDTO.getTag_id(), tagDTO.getMac_address(),
                tagDTO.getInfo(), tagDTO.getWorst_case_rssi(),
                tagDTO.getFlags(), tagDTO.getFirst_contact(),
                tagDTO.getLast_contact(), tagDTO.getMinutes_of_appr_contact()
        );
        tagRepository.save(tagEntity);
        return new TagDTO(tagEntity);
    }
}
