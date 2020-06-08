package org.yale.registry.research.DTOs;

import org.springframework.hateoas.RepresentationModel;

public class ManagerDTO extends RepresentationModel<ManagerDTO> {
    private Long manager_id;

    private String username;

    private String password;

    private String name;

    public ManagerDTO(){}

    public ManagerDTO(Long manager_id, String username, String password, String name) {
        this.manager_id = manager_id;
        this.username = username;
        this.password = password;
        this.name = name;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
