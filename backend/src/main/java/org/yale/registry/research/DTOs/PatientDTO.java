package org.yale.registry.research.DTOs;

import java.util.List;

public class PatientDTO {
    private String name;

    private String email;

    private String address;

    private List<PatientLocationDTO> patientLocationDTOS;

    public PatientDTO(){
    }

    public PatientDTO(String name, String email, String address, List<PatientLocationDTO> patientLocationDTOS) {
        this.name = name;
        this.email = email;
        this.address = address;
        this.patientLocationDTOS = patientLocationDTOS;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public List<PatientLocationDTO> getPatientLocationDTOS() {
        return patientLocationDTOS;
    }

    public void setPatientLocationDTOS(List<PatientLocationDTO> patientLocationDTOS) {
        this.patientLocationDTOS = patientLocationDTOS;
    }
}
