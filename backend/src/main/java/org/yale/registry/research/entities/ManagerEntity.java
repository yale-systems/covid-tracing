package org.yale.registry.research.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.yale.registry.research.DTOs.ManagerDTO;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "managers")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
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
}
