package org.yale.registry.research.entities;

import javax.persistence.*;

@Entity
@Table(name = "volunteers")
public class VolunteerEntity {
    @Id
    @SequenceGenerator(
            name = "volunteers_generator",
            sequenceName = "volunteers_id_seq",
            allocationSize = 1
    )
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "volunteers_generator")
    private Long volunteer_id;

    private String username;

    private String password;

    private String name;

    private String email;

    private Long manager_id;


    public VolunteerEntity(){}

    public VolunteerEntity(Long volunteer_id,
                           String username, String password,
                           String name, String email,
                           Long manager_id) {
        this.volunteer_id = volunteer_id;
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.manager_id = manager_id;
    }

    public Long getVolunteer_id() {
        return volunteer_id;
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

    public String getEmail() {
        return email;
    }

    public Long getManager_id() {
        return manager_id;
    }

    public void setVolunteer_id(Long volunteer_id) {
        this.volunteer_id = volunteer_id;
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

    public void setEmail(String email) {
        this.email = email;
    }

    public void setManager_id(Long manager) {
        this.manager_id = manager;
    }
}
