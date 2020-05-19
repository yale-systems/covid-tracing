package org.yale.registry.research.services;

import org.locationtech.jts.geom.GeometryFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.entities.PatientEntity;
import org.yale.registry.research.repositories.PatientRepository;
import org.yale.registry.research.utilities.DTOUtility;

import java.util.List;
import java.util.Optional;

@Service
public class PatientService {
    private PatientRepository patientRepository;
    private GeometryFactory geometryFactory;
    public static final int MAX_RANGE = 9000;

    @Autowired
    public PatientService(PatientRepository patientRepository, GeometryFactory geometryFactory){
        this.patientRepository = patientRepository;
        this.geometryFactory = geometryFactory;
    }

    public PatientDTO getContactDTOById(Long trace_id){
        Optional<PatientEntity> optionalContactsEntity = patientRepository.findById(trace_id);
        if(!optionalContactsEntity.isPresent()){
            return null;
        }
        PatientEntity patientEntity = optionalContactsEntity.get();
        return DTOUtility.contactsEntityToDTO(patientEntity);
    }

    public List<PatientDTO> getContactDTOsByName(String name){
        List<PatientEntity> contactsEntities = patientRepository.findContactsEntitiesByName(name);
        return DTOUtility.contactsDTOAggregator(contactsEntities);
    }
}
