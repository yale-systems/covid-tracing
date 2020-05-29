package org.yale.registry.research.entities;

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

    private String name;

    public ManagerEntity() {
    }

    public ManagerEntity(Long manager_id, String username,
                         String password, String name) {
        this.manager_id = manager_id;
        this.username = username;
        this.password = password;
        this.name = name;
    }

    public Long getManager_id() {
        return manager_id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getName() {
        return name;
    }

    public void setManager_id(Long manager_id) {
        this.manager_id = manager_id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setName(String name) {
        this.name = name;
    }

}
