package org.yale.registry.research.services;

import org.locationtech.jts.geom.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.PatientLocationDTO;
import org.yale.registry.research.entities.PatientLocationEntity;
import org.yale.registry.research.repositories.PatientLocationRepository;
import org.yale.registry.research.utilities.DTOUtility;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

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

    public List<PatientLocationDTO> getByIDRange(int range){
        Iterable<PatientLocationEntity> researchEntitiesIterable = patientLocationRepository.findAll();
        List<PatientLocationEntity> researchEntitiesList = StreamSupport.stream(researchEntitiesIterable.spliterator(), false)
                .collect(Collectors.toList());

        Random idGenerator = new Random();
        Integer startIndex;
        if(range > MAX_RANGE) { return null; }
        else if(range == MAX_RANGE){ startIndex = 0; }
        else { startIndex = idGenerator.nextInt(9000 - range); }

        List<PatientLocationEntity> researchEntitiesSubList = researchEntitiesList.subList(startIndex, startIndex + range);
        return DTOUtility.patientLocationDTOAggregator(researchEntitiesSubList);
    }

    public PatientLocationDTO getResearchOpportunity(Long id) throws Exception {
        Optional<PatientLocationEntity> optionalResearchEntity = patientLocationRepository.findById(id);
        if(!optionalResearchEntity.isPresent()){
            return null;
        }
        PatientLocationEntity patientLocationEntity = optionalResearchEntity.get();
        return DTOUtility.patientLocationEntityToDTO(patientLocationEntity);
    }

    public void insertEntity(PatientLocationDTO toInsert){
        PatientLocationEntity patientLocationEntity = DTOUtility.patientLocationDTOToEntity(toInsert);
        patientLocationRepository.save(patientLocationEntity);
    }

//    public void insertOrUpdateResearchEntity(TracingEntity researchEntity){
//        tracingRepository.save(researchEntity);
//    }

//    public void deleteResearchEntityById(Long id){
//        tracingRepository.deleteById(id);
//    }


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
