package org.yale.registry.research.entities;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "patients")
public class PatientEntity {
    @Id
    @SequenceGenerator(name = "patients_generator", sequenceName = "patients_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "patients_generator")
    private Long patient_id;

    private String name;

    private String email;

    private String address;

    @OneToMany(orphanRemoval = true, cascade = CascadeType.ALL)
    @JoinColumn(name="patient_id")
    private Set<PatientLocationEntity> tracings;

    public PatientEntity(){}

    public PatientEntity(String name, String email, String address, Set<PatientLocationEntity> tracings) {
        this.name = name;
        this.email = email;
        this.address = address;
        this.tracings = tracings;
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

    public String getAddress() {
        return address;
    }

    public Set<PatientLocationEntity> getTracings() {
        return tracings;
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

    public void setAddress(String address) {
        this.address = address;
    }

    public void setTracings(Set<PatientLocationEntity> tracings) {
        this.tracings = tracings;
    }
}
