package org.yale.registry.research.utilities;

import org.springframework.hateoas.server.mvc.WebMvcLinkBuilder;
import org.yale.registry.research.DTOs.*;
import org.yale.registry.research.controllers.*;

import java.util.List;

public class RESTfulUtility {
    public static void addRestToPatientLocationDTO(PatientLocationDTO patientLocationDTO){
        patientLocationDTO.add(
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientLocationController.class).
                        getById(patientLocationDTO.getId())).withSelfRel(),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientLocationController.class).
                        update(patientLocationDTO)).withRel("update"),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientLocationController.class).
                        delete(patientLocationDTO.getId())).withRel("delete")
        );
//        WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientLocationController.class).
//                getById(patientLocationDTO.getId())).withSelfRel().andAffordance(
//                WebMvcLinkBuilder.afford(WebMvcLinkBuilder.methodOn(PatientLocationController.class).
//                        update(patientLocationDTO))
//        ),
//                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientLocationController.class).
//                        delete(patientLocationDTO.getId())).withRel("delete")
    }

    public static void addRestToPatientLocationDTOs(List<PatientLocationDTO> patientLocationDTOS){
        for(PatientLocationDTO patientLocationDTO: patientLocationDTOS){
            addRestToPatientLocationDTO(patientLocationDTO);
        }
    }

    public static void addRestToPatientDTO(PatientDTO patientDTO){
        patientDTO.add(
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientController.class).
                        getByPatientId(patientDTO.getPatient_id(), null)).withSelfRel(),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientController.class).
                        update(patientDTO)).withRel("update"),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientController.class).
                        reassignment(null)).withRel("reassignment"),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientController.class).
                        delete(patientDTO.getPatient_id())).withRel("delete"),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(ContactController.class).
                        getByPatientId(patientDTO.getPatient_id())).withRel("get_contacts"),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientLocationController.class).
                        getByPatientId(patientDTO.getPatient_id())).withRel("get_locations"),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(ContactController.class).
                        insert(null)).withRel("insert_contact"),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientLocationController.class).
                        insert(null)).withRel("insert_location")
                );
    }

    public static void addRestToPatientDTOs(List<PatientDTO> patientDTOS){
        for(PatientDTO patientDTO: patientDTOS){
            addRestToPatientDTO(patientDTO);
        }
    }

    public static void addRestToContactDTO(ContactDTO contactDTO){
        contactDTO.add(
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(ContactController.class).
                        getByContactId(contactDTO.getContact_id())).withSelfRel(),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(ContactController.class).
                        update(null)).withRel("update"),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(ContactController.class).
                        delete(contactDTO.getContact_id())).withRel("delete")
        );
    }

    public static void addRestToContactDTOs(List<ContactDTO> contactDTOS){
        for(ContactDTO contactDTO: contactDTOS){
            addRestToContactDTO(contactDTO);
        }
    }

    public static void addRestToVolunteerDTO(VolunteerDTO volunteerDTO){
        volunteerDTO.add(
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(VolunteerController.class).
                        getByVolunteerId(volunteerDTO.getVolunteer_id())).withSelfRel(),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(VolunteerController.class).
                        update(volunteerDTO)).withRel("update"),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(VolunteerController.class).
                        delete(volunteerDTO.getVolunteer_id())).withRel("delete"),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientController.class).
                        getByVolunteerId(volunteerDTO.getVolunteer_id())).withRel("get_patients"),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientController.class).
                        insert(null)).withRel("insert_patient")
        );
    }
    public static void addRestToVolunteerDTOs(List<VolunteerDTO> volunteerDTOS){
        for(VolunteerDTO volunteerDTO: volunteerDTOS){
            addRestToVolunteerDTO(volunteerDTO);
        }
    }

    public static void addRestToManagerDTO(ManagerDTO managerDTO){
        managerDTO.add(
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(ManagerController.class).
                        getByManagerId(managerDTO.getManager_id())).withSelfRel(),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(VolunteerController.class).
                        getByManagerId(managerDTO.getManager_id())).withRel("get_volunteers"),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientController.class).
                        getByManagerId(managerDTO.getManager_id(), null)).withRel("get_patients"),
                WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(PatientController.class).
                        getOrphanedByManagerId(managerDTO.getManager_id())).withRel("get_orphaned_patients")
        );
    }
}
