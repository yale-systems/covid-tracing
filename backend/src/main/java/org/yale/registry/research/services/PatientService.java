package org.yale.registry.research.services;

import org.locationtech.jts.geom.GeometryFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.entities.PatientEntity;
import org.yale.registry.research.repositories.PatientLocationRepository;
import org.yale.registry.research.repositories.PatientRepository;
import org.yale.registry.research.utilities.RESTfulUtility;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class PatientService {
    public static final String SUBJECT = "Yale Health Patient Creation";
    private PatientRepository patientRepository;
    private PatientLocationRepository patientLocationRepository;
    private GeometryFactory geometryFactory;
    private MailSender mailSender;

    @Autowired
    public PatientService(PatientRepository patientRepository, PatientLocationRepository patientLocationRepository,
                          GeometryFactory geometryFactory, MailSender mailSender){
        this.patientRepository = patientRepository;
        this.patientLocationRepository = patientLocationRepository;
        this.geometryFactory = geometryFactory;
        this.mailSender = mailSender;
    }

    public PatientDTO getPatientDTOById(Long patient_id){
        Optional<PatientDTO> optionalPatientDTO = patientRepository.findPatientDTOByPatient_id(patient_id);
        if(!optionalPatientDTO.isPresent()){
            return null;
        }
        PatientDTO patientDTO = optionalPatientDTO.get();
        RESTfulUtility.addRestToPatientDTO(patientDTO);
        return patientDTO;
    }

    public List<PatientDTO> getPatientsByManagerId(Long manager_id){
        List<PatientDTO> patientDTOS = patientRepository.findPatientDTOsByManager_id(manager_id);
        RESTfulUtility.addRestToPatientDTOs(patientDTOS);
        return patientDTOS;
    }

    public List<PatientDTO> getOrphanedPatientsByManagerId(Long manager_id){
        List<PatientDTO> patientDTOS =
                patientRepository.findOrphanedPatientDTOsByManager_id(manager_id);
        RESTfulUtility.addRestToPatientDTOs(patientDTOS);
        return patientDTOS;
    }

    public List<PatientDTO> getPatientsByVolunteerId(Long volunteer_id){
        List<PatientDTO> patientDTOS = patientRepository.findPatientDTOsByVolunteer_id(volunteer_id);
        RESTfulUtility.addRestToPatientDTOs(patientDTOS);
        return patientDTOS;
    }

    public void update(PatientDTO patientDTO){
        Optional<PatientEntity> optionalPatientEntity =
                patientRepository.findById(patientDTO.getPatient_id());
        if(optionalPatientEntity.isPresent()){
            PatientEntity patientEntity = optionalPatientEntity.get();
            if(patientDTO.getUsername() != null){
                patientEntity.setUsername(patientDTO.getUsername());
            }
            if(patientDTO.getPassword() != null){
                patientEntity.setPassword(patientDTO.getPassword());
            }
            if(patientDTO.getName() != null){
                patientEntity.setName(patientDTO.getName());
            }
            if(patientDTO.getEmail() != null){
                patientEntity.setEmail(patientDTO.getEmail());
            }
            patientRepository.save(patientEntity);
        }
    }

    public void reassignment(Long patient_id, Long newVolunteerId){
        Optional<PatientEntity> optionalPatientEntity = patientRepository.findById(patient_id);
        if(optionalPatientEntity.isPresent()){
            PatientEntity patientEntity = optionalPatientEntity.get();
            patientEntity.setVolunteer_id(newVolunteerId);
            patientRepository.save(patientEntity);
        }
    }

    public void insert(PatientDTO patientDTO){
        PatientEntity patientEntity = new PatientEntity(
                patientDTO.getPatient_id(), patientDTO.getUsername(),
                patientDTO.getPassword(), patientDTO.getName(),
                patientDTO.getEmail(), patientDTO.getManager_id(),
                patientDTO.getVolunteer_id()
        );
        patientRepository.save(patientEntity);
    }

    public void delete(Long patient_id){
        patientLocationRepository.deleteByPatientId(patient_id);
        patientRepository.deleteById(patient_id);
    }

    @Async
    public void sendCreationEmail(String name, String email, String username, String password){
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject(SUBJECT);
        message.setText(
                "NOTE: THIS EMAIL IS FOR TESTING PURPOSES ONLY, " +
                        "IF YOU RECEIVE THIS EMAIL, IGNORE IT. " +
                        "YALE HEALTH HAS NOT IDENTIFIED THAT YOU HAVE COVID.\n" +
                        "Dear " + name + ",\nYou have been identified as a patient of Yale" +
                        " Health for COVID-19. A username and password for your Yale Health Account"
                        + " has been created with the following credentials.\nUsername: " +
                        username + "\nPassword: " + password + "\nIf you could fill the form" +
                        " out at your earliest convenience it would be appreciated\nSincerely,\n" +
                        "Yale Health"
        );
        mailSender.send(message);
    }

}
