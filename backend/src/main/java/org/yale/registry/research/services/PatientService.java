package org.yale.registry.research.services;

import org.locationtech.jts.geom.GeometryFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.entities.PatientEntity;
import org.yale.registry.research.repositories.PatientRepository;
import org.yale.registry.research.utilities.DTOUtility;

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

    public PatientDTO getPatientDTOById(Long trace_id){
        Optional<PatientEntity> optionalPatientEntity = patientRepository.findById(trace_id);
        if(!optionalPatientEntity.isPresent()){
            return null;
        }
        PatientEntity patientEntity = optionalPatientEntity.get();
        return DTOUtility.patientEntityToDTO(patientEntity);
    }

    public List<PatientDTO> getPatientDTOsByName(String name){
        List<PatientEntity> patientEntities = patientRepository.findPatientEntitiesByName(name);
        return DTOUtility.patientDTOAggregator(patientEntities);
    }
}
