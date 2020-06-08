package org.yale.registry.research.DTOs;

import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.enums.AgeDemographic;

public class ContactDTO extends RepresentationModel<ContactDTO> {
    private Long contact_id;

    private String first_name;

    private String last_name;

    private String email;

    private String phone_number;

    private AgeDemographic age;

    private Boolean household;

    private String nature_of_contact;

    private Boolean healthcare_worker;

    private Long patient_id;


    public ContactDTO(){}

    public ContactDTO(
            Long contact_id, String first_name, String last_name,
            String email, String phone_number, AgeDemographic age,
            Boolean household, String nature_of_contact, Boolean healthcare_worker,
            Long patient_id
    ) {
        this.contact_id = contact_id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.phone_number = phone_number;
        this.age = age;
        this.household = household;
        this.nature_of_contact = nature_of_contact;
        this.healthcare_worker = healthcare_worker;
        this.patient_id = patient_id;
    }

    public Long getContact_id() {
        return contact_id;
    }

    public void setContact_id(Long contact_id) {
        this.contact_id = contact_id;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public AgeDemographic getAge() {
        return age;
    }

    public void setAge(AgeDemographic age) {
        this.age = age;
    }

    public Boolean getHousehold() {
        return household;
    }

    public void setHousehold(Boolean household) {
        this.household = household;
    }

    public String getNature_of_contact() {
        return nature_of_contact;
    }

    public void setNature_of_contact(String nature_of_contact) {
        this.nature_of_contact = nature_of_contact;
    }

    public Boolean getHealthcare_worker() {
        return healthcare_worker;
    }

    public void setHealthcare_worker(Boolean healthcare_worker) {
        this.healthcare_worker = healthcare_worker;
    }

    public Long getPatient_id() {
        return patient_id;
    }

    public void setPatient_id(Long patient_id) {
        this.patient_id = patient_id;
    }
}
