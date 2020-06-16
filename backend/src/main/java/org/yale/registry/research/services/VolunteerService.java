package org.yale.registry.research.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.VolunteerDTO;
import org.yale.registry.research.entities.PatientEntity;
import org.yale.registry.research.entities.VolunteerEntity;
import org.yale.registry.research.repositories.PatientRepository;
import org.yale.registry.research.repositories.VolunteerRepository;
import org.yale.registry.research.utilities.RESTfulUtility;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class VolunteerService {
    private VolunteerRepository volunteerRepository;
    private PatientRepository patientRepository;

    @Autowired
    public VolunteerService(VolunteerRepository volunteerRepository, PatientRepository patientRepository){
        this.volunteerRepository = volunteerRepository;
        this.patientRepository = patientRepository;
    }

    public VolunteerDTO getVolunteerDTOById(Long volunteer_id){
        Optional<VolunteerDTO> optionalVolunteerDTO =
                volunteerRepository.findVolunteerDTOByVolunteer_id(volunteer_id);
        if(!optionalVolunteerDTO.isPresent()){
            return null;
        }
        VolunteerDTO volunteerDTO = optionalVolunteerDTO.get();
        RESTfulUtility.addRestToVolunteerDTO(volunteerDTO);
        return volunteerDTO;
    }

    public List<VolunteerDTO> getVolunteersByManagerId(Long manager_id){
        List<VolunteerDTO> volunteerDTOS =
                volunteerRepository.findVolunteerDTOsByManager_id(manager_id);
        RESTfulUtility.addRestToVolunteerDTOs(volunteerDTOS);
        return volunteerDTOS;
    }

    public VolunteerDTO update(VolunteerDTO volunteerDTO){
        Optional<VolunteerEntity> optionalVolunteerEntity =
                volunteerRepository.findById(volunteerDTO.getVolunteer_id());
        if(optionalVolunteerEntity.isPresent()){
            VolunteerEntity volunteerEntity = optionalVolunteerEntity.get();
            if(volunteerDTO.getUsername() != null){
                volunteerEntity.setUsername(volunteerDTO.getUsername());
            }
            if(volunteerDTO.getPassword() != null){
                volunteerEntity.setPassword(volunteerDTO.getPassword());
            }
            if(volunteerDTO.getName() != null){
                volunteerEntity.setName(volunteerDTO.getName());
            }
            if(volunteerDTO.getEmail() != null){
                volunteerEntity.setEmail(volunteerDTO.getEmail());
            }
            volunteerRepository.save(volunteerEntity);
            VolunteerDTO returnVolunteerDTO = new VolunteerDTO(volunteerEntity);
            RESTfulUtility.addRestToVolunteerDTO(returnVolunteerDTO);
            return returnVolunteerDTO;
        }
        return null;
    }

    public VolunteerDTO insert(VolunteerDTO volunteerDTO){
        VolunteerEntity volunteerEntity = new VolunteerEntity(
                volunteerDTO.getVolunteer_id(), volunteerDTO.getUsername(),
                volunteerDTO.getPassword(), volunteerDTO.getName(),
                volunteerDTO.getEmail(), volunteerDTO.getManager_id()
        );
        volunteerRepository.save(volunteerEntity);
        VolunteerDTO returnVolunteerDTO = new VolunteerDTO(volunteerEntity);
        RESTfulUtility.addRestToVolunteerDTO(returnVolunteerDTO);
        return returnVolunteerDTO;
    }

    public void delete(Long volunteer_id){
        List<PatientEntity> patientEntities = patientRepository.
                findPatientEntitiesByVolunteer_id(volunteer_id);
        for(PatientEntity patientEntity: patientEntities){
            patientEntity.setVolunteer_id(null);
        }
        patientRepository.saveAll(patientEntities);
        volunteerRepository.deleteById(volunteer_id);
    }

}
