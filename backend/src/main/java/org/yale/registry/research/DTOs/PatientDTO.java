package org.yale.registry.research.DTOs;

import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.entities.PatientEntity;

public class PatientDTO extends RepresentationModel<PatientDTO> {
    private Long patient_id;

    private String username;

    private String password;

    private String name;

    private String email;

    private Long manager_id;

    private Long volunteer_id;

    public PatientDTO(){
    }

    public PatientDTO(Long patient_id, String username,
                      String password, String name,
                      String email, Long manager_id,
                      Long volunteer_id) {
        this.patient_id = patient_id;
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.manager_id = manager_id;
        this.volunteer_id = volunteer_id;
    }

    public PatientDTO(PatientEntity patientEntity) {
        this.patient_id = patientEntity.getPatient_id();
        this.username = patientEntity.getUsername();
        this.password = patientEntity.getPassword();
        this.name = patientEntity.getName();
        this.email = patientEntity.getEmail();
        this.manager_id = patientEntity.getManager_id();
        this.volunteer_id = patientEntity.getVolunteer_id();
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

    public void setPatient_id(Long patient_id) {
        this.patient_id = patient_id;
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

    public void setManager_id(Long manager_id) {
        this.manager_id = manager_id;
    }

    public void setVolunteer_id(Long volunteer_id) {
        this.volunteer_id = volunteer_id;
    }

}
