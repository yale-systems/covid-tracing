package org.yale.registry.research.DTOs;

import org.yale.registry.research.repositories.TracingRepository;

import java.util.List;

public class ContactsDTO {
    private String name;

    private String email;

    private String address;

    private List<TracingDTO> tracingDTOS;

    public ContactsDTO(){
    }

    public ContactsDTO(String name, String email, String address, List<TracingDTO> tracingDTOS) {
        this.name = name;
        this.email = email;
        this.address = address;
        this.tracingDTOS = tracingDTOS;
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

    public List<TracingDTO> getTracingDTOS() {
        return tracingDTOS;
    }

    public void setTracingDTOS(List<TracingDTO> tracingDTOS) {
        this.tracingDTOS = tracingDTOS;
    }
}
