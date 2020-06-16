package org.yale.registry.research.DTOs;

import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.entities.VolunteerEntity;

public class VolunteerDTO extends RepresentationModel<VolunteerDTO> {
    private Long volunteer_id;

    private String username;

    private String password;

    private String name;

    private String email;

    private Long manager_id;

    public VolunteerDTO(){}

    public VolunteerDTO(
            Long volunteer_id, String username,
            String password, String name,
            String email, Long manager_id
    ) {
        this.volunteer_id = volunteer_id;
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.manager_id = manager_id;
    }

    public VolunteerDTO(VolunteerEntity volunteerEntity) {
        this.volunteer_id = volunteerEntity.getVolunteer_id();
        this.username = volunteerEntity.getUsername();
        this.password = volunteerEntity.getPassword();
        this.name = volunteerEntity.getName();
        this.email = volunteerEntity.getEmail();
        this.manager_id = volunteerEntity.getManager_id();
    }

    public Long getVolunteer_id() {
        return volunteer_id;
    }

    public void setVolunteer_id(Long volunteer_id) {
        this.volunteer_id = volunteer_id;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Long getManager_id() {
        return manager_id;
    }

    public void setManager_id(Long manager_id) {
        this.manager_id = manager_id;
    }
}
