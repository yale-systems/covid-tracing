package org.yale.registry.research.entities;

import org.yale.registry.research.DTOs.ManagerDTO;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "managers")
public class ManagerEntity implements Serializable {
    @Id
    @SequenceGenerator(
            name = "managers_generator",
            sequenceName = "managers_id_seq",
            allocationSize = 1
    )
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "managers_generator")
    private Long manager_id;

    private String username;

    private String password;

    private String org_name;

    public ManagerEntity() {
    }

    public ManagerEntity(Long manager_id, String username,
                         String password, String org_name) {
        this.manager_id = manager_id;
        this.username = username;
        this.password = password;
        this.org_name = org_name;
    }


    public ManagerEntity(String username,
                         String password, String org_name) {
        this.username = username;
        this.password = password;
        this.org_name = org_name;
    }

    public ManagerEntity(ManagerDTO managerDTO){
        this.manager_id = managerDTO.getManager_id();
        this.username = managerDTO.getUsername();
        this.password = managerDTO.getPassword();
        this.org_name = managerDTO.getOrg_name();
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
