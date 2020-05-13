package org.yale.registry.research.services;

import org.locationtech.jts.geom.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.TracingDTO;
import org.yale.registry.research.entities.TracingEntity;
import org.yale.registry.research.repositories.TracingRepository;
import org.yale.registry.research.utilities.DTOUtility;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Service
public class TracingService {
    private TracingRepository tracingRepository;
    private GeometryFactory geometryFactory;
    public static final int MAX_RANGE = 9000;

    @Autowired
    public TracingService(TracingRepository tracingRepository, GeometryFactory geometryFactory){
        this.tracingRepository = tracingRepository;
        this.geometryFactory = geometryFactory;
    }

    public List<TracingDTO> getInRange(Double longitude, Double latitude,
                                       Integer range, Date startTime){
        Point point = longLatToPoint(longitude, latitude);
        List<TracingEntity> withinDistance = tracingRepository.findWithinDistance(point, range, startTime);
        return DTOUtility.tracingDTOAggregator(withinDistance);
    }

    public List<TracingDTO> getByIDRange(int range){
        Iterable<TracingEntity> researchEntitiesIterable = tracingRepository.findAll();
        List<TracingEntity> researchEntitiesList = StreamSupport.stream(researchEntitiesIterable.spliterator(), false)
                .collect(Collectors.toList());

        Random idGenerator = new Random();
        Integer startIndex;
        if(range > MAX_RANGE) { return null; }
        else if(range == MAX_RANGE){ startIndex = 0; }
        else { startIndex = idGenerator.nextInt(9000 - range); }

        List<TracingEntity> researchEntitiesSubList = researchEntitiesList.subList(startIndex, startIndex + range);
        return DTOUtility.tracingDTOAggregator(researchEntitiesSubList);
    }

    public TracingDTO getResearchOpportunity(Long id) throws Exception {
        Optional<TracingEntity> optionalResearchEntity = tracingRepository.findById(id);
        if(!optionalResearchEntity.isPresent()){
            return null;
        }
        TracingEntity tracingEntity = optionalResearchEntity.get();
        return DTOUtility.tracingEntityToDTO(tracingEntity);
    }

    public void insertEntity(TracingDTO toInsert){
        TracingEntity tracingEntity = DTOUtility.tracingDTOToEntity(toInsert);
        tracingRepository.save(tracingEntity);
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
