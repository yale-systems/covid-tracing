package org.yale.registry.research.services;

import org.locationtech.jts.geom.GeometryFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.entities.PatientEntity;
import org.yale.registry.research.repositories.PatientRepository;
import org.yale.registry.research.utilities.RESTfulUtility;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class PatientService {
    private PatientRepository patientRepository;
    private GeometryFactory geometryFactory;
    public static final int MAX_RANGE = 9000;

    @Autowired
    public PatientService(PatientRepository patientRepository, GeometryFactory geometryFactory){
        this.patientRepository = patientRepository;
        this.geometryFactory = geometryFactory;
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
        patientRepository.deleteById(patient_id);
    }

}
