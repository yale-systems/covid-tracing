package org.yale.registry.research.DTOs;

import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.entities.ManagerEntity;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

public class ManagerDTO extends RepresentationModel<ManagerDTO> {
    private Long manager_id;

    private String username;

    private String password;

    private String org_name;

    public ManagerDTO() {
    }

    public ManagerDTO(Long manager_id, String username,
                         String password, String org_name) {
        this.manager_id = manager_id;
        this.username = username;
        this.password = password;
        this.org_name = org_name;
    }


    public ManagerDTO(String username, String password, String org_name) {
        this.username = username;
        this.password = password;
        this.org_name = org_name;
    }

    public ManagerDTO(ManagerEntity managerEntity){
        this.manager_id = managerEntity.getManager_id();
        this.username = managerEntity.getUsername();
        this.password = managerEntity.getPassword();
        this.org_name = managerEntity.getOrg_name();
    }

    public Long getManager_id() {
        return manager_id;
    }

    public void setManager_id(Long manager_id) {
        this.manager_id = manager_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getOrg_name() {
        return org_name;
    }

    public void setOrg_name(String name) {
        this.org_name = name;
    }
}
