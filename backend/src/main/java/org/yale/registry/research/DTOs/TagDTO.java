package org.yale.registry.research.DTOs;

import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.entities.TagEntity;

public class TagDTO extends RepresentationModel<TagDTO> {
    private Long tag_id;

    private String mac_address;

    private String info;

    private String worst_case_rssi;

    private String flags;

    private Integer minutes_of_appr_contact;


    public TagDTO(){

    }

    public TagDTO(Long tag_id, String mac_address, String info, String worst_case_rssi, String flags, Integer minutes_of_appr_contact) {
        this.tag_id = tag_id;
        this.mac_address = mac_address;
        this.info = info;
        this.worst_case_rssi = worst_case_rssi;
        this.flags = flags;
        this.minutes_of_appr_contact = minutes_of_appr_contact;
    }

    public TagDTO(TagEntity tagEntity){
        this.tag_id = tagEntity.getTag_id();
        this.mac_address = tagEntity.getMac_address();
        this.info = tagEntity.getInfo();
        this.worst_case_rssi = tagEntity.getWorst_case_rssi();
        this.flags = tagEntity.getFlags();
        this.minutes_of_appr_contact = tagEntity.getMinutes_of_appr_contact();
    }

    public Long getTag_id() {
        return tag_id;
    }

    public void setTag_id(Long tag_id) {
        this.tag_id = tag_id;
    }

    public String getMac_address() {
        return mac_address;
    }

    public void setMac_address(String mac_address) {
        this.mac_address = mac_address;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getWorst_case_rssi() {
        return worst_case_rssi;
    }

    public void setWorst_case_rssi(String worst_case_rssi) {
        this.worst_case_rssi = worst_case_rssi;
    }

    public String getFlags() {
        return flags;
    }

    public void setFlags(String flags) {
        this.flags = flags;
    }

    public Integer getMinutes_of_appr_contact() {
        return minutes_of_appr_contact;
    }

    public void setMinutes_of_appr_contact(Integer minutes_of_appr_contact) {
        this.minutes_of_appr_contact = minutes_of_appr_contact;
    }
}
