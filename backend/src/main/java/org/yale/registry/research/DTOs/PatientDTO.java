package org.yale.registry.research.DTOs;

import java.util.List;

public class PatientDTO {
    private String name;

    private String email;

    private List<PatientLocationDTO> patientLocationDTOS;

    public PatientDTO(){
    }

    public PatientDTO(String name, String email, List<PatientLocationDTO> patientLocationDTOS) {
        this.name = name;
        this.email = email;
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

    public List<PatientLocationDTO> getPatientLocationDTOS() {
        return patientLocationDTOS;
    }

    public void setPatientLocationDTOS(List<PatientLocationDTO> patientLocationDTOS) {
        this.patientLocationDTOS = patientLocationDTOS;
    }
}
