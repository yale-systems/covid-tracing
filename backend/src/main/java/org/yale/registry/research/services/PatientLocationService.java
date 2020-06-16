package org.yale.registry.research.services;

import org.locationtech.jts.geom.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.DTOs.PatientLocationDTO;
import org.yale.registry.research.entities.PatientLocationEntity;
import org.yale.registry.research.repositories.PatientLocationRepository;
import org.yale.registry.research.utilities.DTOUtility;
import org.yale.registry.research.utilities.RESTfulUtility;

import java.util.*;

@Service
public class PatientLocationService {
    private PatientLocationRepository patientLocationRepository;
    private GeometryFactory geometryFactory;
    public static final int MAX_RANGE = 9000;

    @Autowired
    public PatientLocationService(PatientLocationRepository patientLocationRepository, GeometryFactory geometryFactory){
        this.patientLocationRepository = patientLocationRepository;
        this.geometryFactory = geometryFactory;
    }

    public List<PatientLocationDTO> getInRange(Double longitude, Double latitude,
                                               Integer range, Date startTime){
        Point point = longLatToPoint(longitude, latitude);
        List<PatientLocationEntity> withinDistance = patientLocationRepository.findWithinDistance(point, range, startTime);
        return DTOUtility.patientLocationDTOAggregator(withinDistance);
    }

    public PatientLocationDTO getPatientLocationById(Long id){
        Optional<PatientLocationEntity> optionalPatientLocationEntity = patientLocationRepository.findById(id);
        PatientLocationDTO patientLocationDTO =
                optionalPatientLocationEntity.map(DTOUtility::patientLocationEntityToDTO).
                        orElse(null);
        if(patientLocationDTO != null){
            RESTfulUtility.addRestToPatientLocationDTO(patientLocationDTO);
        }
        return patientLocationDTO;
    }

    public List<PatientLocationDTO> getByPatientId(Long patient_id){
        List<PatientLocationEntity> patientLocationEntities =
                patientLocationRepository.findPatientLocationEntitiesByPatientId(patient_id);
        List<PatientLocationDTO> patientLocationDTOS =
                DTOUtility.patientLocationDTOAggregator(patientLocationEntities);
        RESTfulUtility.addRestToPatientLocationDTOs(patientLocationDTOS);
        return patientLocationDTOS;
    }

    public PatientLocationDTO insert(PatientLocationDTO patientLocationDTO){
        PatientLocationEntity patientLocationEntity = DTOUtility.patientLocationDTOToEntity(patientLocationDTO);
        patientLocationRepository.save(patientLocationEntity);
        PatientLocationDTO returnPatientLocationDTO = new PatientLocationDTO(patientLocationEntity);
        RESTfulUtility.addRestToPatientLocationDTO(returnPatientLocationDTO);
        return returnPatientLocationDTO;
    }

    public PatientLocationDTO update(PatientLocationDTO patientLocationDTO){
        Optional<PatientLocationEntity> optionalPatientLocationEntity =
                patientLocationRepository.findById(patientLocationDTO.getId());
        if(optionalPatientLocationEntity.isPresent()){
            PatientLocationEntity patientLocationEntity = optionalPatientLocationEntity.get();
            if(patientLocationDTO.getStart_time() != null){
                patientLocationEntity.setStart_time(patientLocationDTO.getStart_time());
            }
            if(patientLocationDTO.getEnd_time() != null){
                patientLocationEntity.setEnd_time(patientLocationDTO.getEnd_time());
            }
            if(patientLocationDTO.isConfirmed() != null){
                patientLocationEntity.setConfirmed(patientLocationDTO.isConfirmed());
            }
            if(patientLocationDTO.getGeom() != null){
                patientLocationEntity.setGeom(patientLocationDTO.getGeom());
            }
            if(patientLocationDTO.getPatient_id() != null){
                patientLocationEntity.setPatient_id(patientLocationDTO.getPatient_id());
            }
            patientLocationRepository.save(patientLocationEntity);
            PatientLocationDTO returnPatientLocationDTO = new PatientLocationDTO(patientLocationEntity);
            RESTfulUtility.addRestToPatientLocationDTO(returnPatientLocationDTO);
            return returnPatientLocationDTO;
        }
        return null;
    }

    public void delete(Long id){
        patientLocationRepository.deleteById(id);
    }

    private Point longLatToPoint(Double longitude, Double latitude){
        Coordinate coordinate = new Coordinate(longitude, latitude);
        return geometryFactory.createPoint(coordinate);
    }

    private Float jitterLat(Float latitude){
        Random rand = new Random();
        return new Float((((rand.nextFloat() * 2 - 1) / 100.0) + latitude));
    }

    private Float jitterLong(Float longitude){
        Random rand = new Random();
        return new Float((((rand.nextFloat() * 2 - 1) / 500.0) + longitude));
    }
}
