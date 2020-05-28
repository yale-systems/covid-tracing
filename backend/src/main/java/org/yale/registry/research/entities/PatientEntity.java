package org.yale.registry.research.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "patients")
public class PatientEntity implements Serializable {
    @Id
    @SequenceGenerator(name = "patients_generator", sequenceName = "patients_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "patients_generator")
    private Long patient_id;

    private String name;

    private String email;

//    orphanRemoval = false, cascade = {CascadeType.PERSIST, CascadeType.REMOVE}
    // cascadetype SHOULD NOT have delete for volunteer entity
    @OneToMany(
            mappedBy = "patient",
            orphanRemoval = true,
            cascade = CascadeType.ALL
    )
    private List<PatientLocationEntity> tracings;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "manager_id")
    private ManagerEntity manager;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "volunteer_id")
    private VolunteerEntity volunteer;


    public PatientEntity(){}

    public PatientEntity(String name, String email,
                         List<PatientLocationEntity> tracings,
                         ManagerEntity manager, VolunteerEntity volunteer) {
        this.name = name;
        this.email = email;
        this.tracings = tracings;
        this.manager = manager;
        this.volunteer = volunteer;
    }

    public void addPatientLocation(PatientLocationEntity patientLocationEntity){
        tracings.add(patientLocationEntity);
        patientLocationEntity.setPatient(this);
    }

    public void removePatientLocation(PatientLocationEntity patientLocationEntity){
        tracings.remove(patientLocationEntity);
        patientLocationEntity.setPatient(null);
    }

    public Long getPatient_id() {
        return patient_id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public List<PatientLocationEntity> getTracings() {
        return tracings;
    }

    public ManagerEntity getManager() {
        return manager;
    }

    public VolunteerEntity getVolunteer() {
        return volunteer;
    }

    public void setPatient_id(Long trace_id) {
        this.patient_id = trace_id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setTracings(List<PatientLocationEntity> tracings) {
        this.tracings = tracings;
    }

    public void setManager(ManagerEntity manager) {
        this.manager = manager;
    }

    public void setVolunteer(VolunteerEntity volunteer) {
        this.volunteer = volunteer;
    }
}
