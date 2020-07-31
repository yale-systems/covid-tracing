package org.yale.registry.research.DTOs;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.entities.ManagerEntity;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ManagerDTO extends RepresentationModel<ManagerDTO> {
    private Long manager_id;

    private String username;

    private String password;

    private String org_name;


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
}
