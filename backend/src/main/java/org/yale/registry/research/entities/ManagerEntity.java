package org.yale.registry.research.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

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

    @OneToMany(
            mappedBy = "manager",
            cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}
    )
    private List<VolunteerEntity> volunteers;

    @OneToMany(
            mappedBy = "manager",
            cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}
    )
    private List<PatientEntity> patients;


    public ManagerEntity() {
    }

    public ManagerEntity(Long manager_id, String username,
                         String password, String name,
                         List<VolunteerEntity> volunteers,
                         List<PatientEntity> patients) {
        this.manager_id = manager_id;
        this.username = username;
        this.password = password;
        this.name = name;
        this.volunteers = volunteers;
        this.patients = patients;
    }

    public void addVolunteer(VolunteerEntity volunteerEntity){
        volunteers.add(volunteerEntity);
        volunteerEntity.setManager(this);
    }

    public void removeVolunteer(VolunteerEntity volunteerEntity){
        volunteers.remove(volunteerEntity);
        volunteerEntity.setManager(null);
    }

    public void addPatient(PatientEntity patientEntity){
        patients.add(patientEntity);
        patientEntity.setManager(this);
    }

    public void removePatient(PatientEntity patientEntity){
        patients.remove(patientEntity);
        patientEntity.setManager(null);
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

    public List<VolunteerEntity> getVolunteers() {
        return volunteers;
    }

    public List<PatientEntity> getPatients() {
        return patients;
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

    public void setPatients(List<PatientEntity> patients) {
        this.patients = patients;
    }

    public void setVolunteers(List<VolunteerEntity> volunteers) {
        this.volunteers = volunteers;
    }
}
