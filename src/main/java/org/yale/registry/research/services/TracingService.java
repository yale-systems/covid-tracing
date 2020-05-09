package org.yale.registry.research.services;

import com.bedatadriven.jackson.datatype.jts.parsers.PointParser;
import org.locationtech.jts.geom.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.TracingDTO;
import org.yale.registry.research.entities.TracingEntity;
import org.yale.registry.research.repositories.TracingRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Random;
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

    public List<TracingDTO> getInRange(Double longitude, Double latitude, Integer range){
        Point point = longLatToPoint(longitude, latitude);
        List<TracingEntity> withinDistance = tracingRepository.findWithinDistance(point, range);
        return dtoAggregator(withinDistance);
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
        return dtoAggregator(researchEntitiesSubList);
    }

    public TracingDTO getResearchOpportunity(Long id) throws Exception {
        Optional<TracingEntity> optionalResearchEntity = tracingRepository.findById(id);
        if(!optionalResearchEntity.isPresent()){
            return null;
        }
        TracingEntity tracingEntity = optionalResearchEntity.get();
        return entityToDTO(tracingEntity);
    }

    public void insertEntity(TracingDTO toInsert){
        TracingEntity tracingEntity = DTOToEntity(toInsert);
        tracingRepository.save(tracingEntity);
    }

//    public void insertOrUpdateResearchEntity(TracingEntity researchEntity){
//        tracingRepository.save(researchEntity);
//    }

//    public void deleteResearchEntityById(Long id){
//        tracingRepository.deleteById(id);
//    }

    private List<TracingDTO> dtoAggregator(List<TracingEntity> tracingEntityList){
        List<TracingDTO> dtoAggregate = new ArrayList<>();
        int listSize = tracingEntityList.size();
        for(TracingEntity cur: tracingEntityList){
            dtoAggregate.add(entityToDTO(cur));
        }
        return dtoAggregate;
    }

    private TracingDTO entityToDTO(TracingEntity tracingEntity){
        return new TracingDTO(tracingEntity.getTrace_id(), tracingEntity.getStart_time(),
                tracingEntity.getEnd_time(), tracingEntity.isConfirmed(), tracingEntity.getGeom());
    }

    private TracingEntity DTOToEntity(TracingDTO tracingDTO){
        return new TracingEntity(tracingDTO.getTrace_id(), tracingDTO.getStart_time(),
                tracingDTO.getEnd_time(), tracingDTO.isConfirmed(), tracingDTO.getGeom());
    }

    private Point longLatToPoint(Double longitude, Double latitude){
        Coordinate coordinate = new Coordinate(longitude, latitude);
        return geometryFactory.createPoint(coordinate);
    }

}
