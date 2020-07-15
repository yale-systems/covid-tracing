package org.yale.registry.research.services;

import org.locationtech.jts.geom.GeometryFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.entities.PatientEntity;
import org.yale.registry.research.exceptions.custom.IDNotFoundException;
import org.yale.registry.research.repositories.EventRepository;
import org.yale.registry.research.repositories.PatientRepository;
import org.yale.registry.research.utilities.RESTfulUtility;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class PatientService {
    public static final String SUBJECT = "Yale Health Patient Creation";
    private PatientRepository patientRepository;
    private EventRepository eventRepository;
    private GeometryFactory geometryFactory;
    private MailSender mailSender;

    @Autowired
    public PatientService(PatientRepository patientRepository, EventRepository eventRepository,
                          GeometryFactory geometryFactory, MailSender mailSender){
        this.patientRepository = patientRepository;
        this.eventRepository = eventRepository;
        this.geometryFactory = geometryFactory;
        this.mailSender = mailSender;
    }

    public PatientDTO getPatientDTOById(Long patient_id){
        Optional<PatientEntity> optionalPatientEntity = patientRepository.findPatientEntityByPatient_id(patient_id);
        if(!optionalPatientEntity.isPresent()){
            // patient with given ID wasn't found, so throw an IDNotFoundException
            throw new IDNotFoundException(patient_id, "patient");
        }
        PatientDTO patientDTO = new PatientDTO(optionalPatientEntity.get());
        RESTfulUtility.addRestToPatientDTO(patientDTO);
        return patientDTO;
    }

    public List<PatientDTO> getPatientsByManagerId(Long manager_id){
        List<PatientDTO> patientDTOS = new ArrayList<>();
        List<PatientEntity> patientEntities = patientRepository.findPatientEntitiesByManager_id(manager_id);
        for(PatientEntity patientEntity: patientEntities){
            patientDTOS.add(new PatientDTO(patientEntity));
        }
        RESTfulUtility.addRestToPatientDTOs(patientDTOS);
        return patientDTOS;
    }

    public List<PatientDTO> getOrphanedPatientsByManagerId(Long manager_id){
        List<PatientDTO> patientDTOS = new ArrayList<>();
        List<PatientEntity> patientEntities =
                patientRepository.findOrphanedPatientEntitiesByManager_id(manager_id);
        for(PatientEntity patientEntity: patientEntities){
            patientDTOS.add(new PatientDTO(patientEntity));
        }
        RESTfulUtility.addRestToPatientDTOs(patientDTOS);
        return patientDTOS;
    }

    public List<PatientDTO> getPatientsByVolunteerId(Long volunteer_id){
        List<PatientDTO> patientDTOS = new ArrayList<>();
        List<PatientEntity> patientEntities =
                patientRepository.findPatientEntitiesByVolunteer_id(volunteer_id);
        for(PatientEntity patientEntity: patientEntities){
            patientDTOS.add(new PatientDTO(patientEntity));
        }
        RESTfulUtility.addRestToPatientDTOs(patientDTOS);
        return patientDTOS;
    }

    public PatientDTO update(PatientDTO patientDTO){
        Optional<PatientEntity> optionalPatientEntity =
                patientRepository.findById(patientDTO.getPatient_id());
        if(optionalPatientEntity.isPresent()){
            PatientEntity patientEntity = optionalPatientEntity.get();
            patientEntity.update(patientDTO);
            patientRepository.save(patientEntity);
            PatientDTO returnPatientDTO = new PatientDTO(patientEntity);
            RESTfulUtility.addRestToPatientDTO(returnPatientDTO);
            return returnPatientDTO;
        }
        return null;
    }

    public PatientDTO reassignment(Long patient_id, Long newVolunteerId){
        Optional<PatientEntity> optionalPatientEntity = patientRepository.findById(patient_id);
        if(optionalPatientEntity.isPresent()){
            PatientEntity patientEntity = optionalPatientEntity.get();
            patientEntity.setVolunteer_id(newVolunteerId);
            patientRepository.save(patientEntity);
            PatientDTO returnPatientDTO = new PatientDTO(patientEntity);
            RESTfulUtility.addRestToPatientDTO(returnPatientDTO);
            return returnPatientDTO;
        }
        // patient with given ID wasn't found, so throw an IDNotFoundException
        throw new IDNotFoundException(patient_id, "patient");
    }

    public PatientDTO insert(PatientDTO patientDTO){
        PatientEntity patientEntity = new PatientEntity(patientDTO);
        patientRepository.save(patientEntity);
        PatientDTO returnPatientDTO = new PatientDTO(patientEntity);
        RESTfulUtility.addRestToPatientDTO(returnPatientDTO);
        return returnPatientDTO;
    }

    public void delete(Long patient_id){
        eventRepository.deleteByPatientId(patient_id);
        patientRepository.deleteById(patient_id);
    }

    @Async
    public void sendCreationEmail(String name, String email, String username, String password){
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject(SUBJECT);
        message.setText(
                "WARNING: THIS EMAIL IS FOR TESTING PURPOSES ONLY, " +
                        "IF YOU RECEIVE THIS EMAIL, IGNORE IT. " +
                        "YALE HEALTH HAS NOT IDENTIFIED THAT YOU HAVE COVID.\n\n\n\n\n" +
                        "Dear " + name + ",\n\nYou have been identified as a patient of Yale" +
                        " Health for COVID-19. A username and password for your Yale Health Account"
                        + " has been created with the following credentials.\nUsername: " +
                        username + "\nPassword: " + password + "\nIf you could fill the form" +
                        " out at your earliest convenience it would be appreciated\n\nSincerely,\n" +
                        "Yale Health"
        );
        mailSender.send(message);
    }

}
