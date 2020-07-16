package org.yale.registry.research.DTOs;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.entities.TagEntity;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TagDTO extends RepresentationModel<TagDTO> {
    private Long tag_id;

    private String mac_address;

    private String info;

    private String worst_case_rssi;

    private String flags;

    private String first_contact;

    private String last_contact;

    private Integer minutes_of_appr_contact;


    public TagDTO(TagEntity tagEntity){
        this.tag_id = tagEntity.getTag_id();
        this.mac_address = tagEntity.getMac_address();
        this.info = tagEntity.getInfo();
        this.worst_case_rssi = tagEntity.getWorst_case_rssi();
        this.flags = tagEntity.getFlags();
        this.minutes_of_appr_contact = tagEntity.getMinutes_of_appr_contact();
    }
}
