package org.yale.registry.research.entities;

import javax.persistence.*;
import java.util.List;

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

    @OneToMany(
            mappedBy = "volunteer",
            cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}
    )
    private List<PatientEntity> patients;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "manager_id")
    private ManagerEntity manager;


    public VolunteerEntity(){}

    public VolunteerEntity(Long volunteer_id,
                           String username, String password,
                           String name, String email,
                           List<PatientEntity> patients, ManagerEntity manager) {
        this.volunteer_id = volunteer_id;
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.patients = patients;
        this.manager = manager;
    }

    public void addPatient(PatientEntity patientEntity){
        patients.add(patientEntity);
        patientEntity.setVolunteer(this);
    }

    public void removePatient(PatientEntity patientEntity){
        patients.remove(patientEntity);
        patientEntity.setVolunteer(null);
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

    public List<PatientEntity> getPatients() {
        return patients;
    }

    public ManagerEntity getManager() {
        return manager;
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

    public void setPatients(List<PatientEntity> patients) {
        this.patients = patients;
    }

    public void setManager(ManagerEntity manager) {
        this.manager = manager;
    }
}
