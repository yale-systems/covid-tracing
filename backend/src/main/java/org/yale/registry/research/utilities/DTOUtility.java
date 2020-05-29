package org.yale.registry.research.utilities;

import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.DTOs.PatientLocationDTO;
import org.yale.registry.research.entities.PatientLocationEntity;

import java.util.ArrayList;
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
        return new PatientLocationDTO(
                patientLocationEntity.getId(), patientLocationEntity.getStart_time(),
                patientLocationEntity.getEnd_time(), patientLocationEntity.isConfirmed(),
                patientLocationEntity.getGeom(), patientLocationEntity.getPatient_id()
        );
    }

    public static PatientLocationEntity patientLocationDTOToEntity(PatientLocationDTO patientLocationDTO){
        return new PatientLocationEntity(
                patientLocationDTO.getStart_time(), patientLocationDTO.getEnd_time(),
                patientLocationDTO.isConfirmed(), patientLocationDTO.getGeom(),
                patientLocationDTO.getPatient_id()
                );
    }

    public static PatientDTO patientEntityToDTO(PatientDTO patientEntity){
        return new PatientDTO(
                patientEntity.getPatient_id(), patientEntity.getUsername(),
                patientEntity.getPassword(), patientEntity.getName(),
                patientEntity.getEmail(), patientEntity.getManager_id(),
                patientEntity.getVolunteer_id()
                );
    }

    public static List<PatientDTO> patientDTOAggregator(List<PatientDTO> patientEntityList){
        List<PatientDTO> dtoAggregate = new ArrayList<>();
        for(PatientDTO cur: patientEntityList){
            dtoAggregate.add(patientEntityToDTO(cur));
        }
        return dtoAggregate;
    }
}
