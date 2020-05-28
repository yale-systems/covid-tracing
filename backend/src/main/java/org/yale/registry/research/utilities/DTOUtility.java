package org.yale.registry.research.utilities;

import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.DTOs.PatientLocationDTO;
import org.yale.registry.research.entities.PatientEntity;
import org.yale.registry.research.entities.PatientLocationEntity;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class DTOUtility {

    public static List<PatientLocationDTO> patientLocationDTOAggregator(List<PatientLocationEntity> patientLocationEntityList){
        List<PatientLocationDTO> dtoAggregate = new ArrayList<>();
        for(PatientLocationEntity cur: patientLocationEntityList){
            dtoAggregate.add(patientLocationEntityToDTO(cur));
        }
        return dtoAggregate;
    }

    public static PatientLocationDTO patientLocationEntityToDTO(PatientLocationEntity patientLocationEntity){
        return new PatientLocationDTO(patientLocationEntity.getId(), patientLocationEntity.getStart_time(),
                patientLocationEntity.getEnd_time(), patientLocationEntity.isConfirmed(), patientLocationEntity.getGeom());
    }

    public static PatientLocationEntity patientLocationDTOToEntity(PatientLocationDTO patientLocationDTO){
        return new PatientLocationEntity(patientLocationDTO.getStart_time(),
                patientLocationDTO.getEnd_time(), patientLocationDTO.isConfirmed(), patientLocationDTO.getGeom());
    }

    public static PatientDTO patientEntityToDTO(PatientEntity patientEntity){
        List<PatientLocationEntity> tracingEntities = new ArrayList<>(patientEntity.getTracings());
        List<PatientLocationDTO> patientLocationDTOS = patientLocationDTOAggregator(tracingEntities);
        patientLocationDTOS.sort(Comparator.comparing(PatientLocationDTO::getStart_time));
        return new PatientDTO(patientEntity.getName(), patientEntity.getEmail(), patientLocationDTOS);
    }

    public static List<PatientDTO> patientDTOAggregator(List<PatientEntity> patientEntityList){
        List<PatientDTO> dtoAggregate = new ArrayList<>();
        for(PatientEntity cur: patientEntityList){
            dtoAggregate.add(patientEntityToDTO(cur));
        }
        return dtoAggregate;
    }
}
