package org.yale.registry.research.entities;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "patients")
public class PatientEntity implements Serializable {
    @Id
    @SequenceGenerator(name = "patients_generator", sequenceName = "patients_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "patients_generator")
    private Long patient_id;

    private String username;

    private String password;

    private String name;

    private String email;

    private Long manager_id;

    private Long volunteer_id;


    public PatientEntity(){}

    public PatientEntity(
            Long patient_id, String username,
            String password, String name,
            String email, Long manager_id,
            Long volunteer_id
    ) {
        this.patient_id = patient_id;
        this.password = password;
        this.username = username;
        this.name = name;
        this.email = email;
        this.manager_id = manager_id;
        this.volunteer_id = volunteer_id;
    }

    public PatientEntity(
            String username, String password,
            String name, String email,
            Long manager_id, Long volunteer
    ) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.manager_id = manager_id;
        this.volunteer_id = volunteer;
    }

    public Long getPatient_id() {
        return patient_id;
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

    public Long getVolunteer_id() {
        return volunteer_id;
    }

    public void setPatient_id(Long trace_id) {
        this.patient_id = trace_id;
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

    public void setVolunteer_id(Long volunteer) {
        this.volunteer_id = volunteer;
    }
}
