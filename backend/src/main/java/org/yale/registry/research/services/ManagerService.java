package org.yale.registry.research.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.ManagerDTO;
import org.yale.registry.research.DTOs.VolunteerDTO;
import org.yale.registry.research.repositories.ManagerRepository;
import org.yale.registry.research.utilities.RESTfulUtility;

import javax.transaction.Transactional;
import java.util.Optional;

@Service
@Transactional
public class ManagerService {
    private ManagerRepository managerRepository;

    @Autowired
    public ManagerService(ManagerRepository managerRepository) {
        this.managerRepository = managerRepository;
    }

    public ManagerDTO getManagerDTOById(Long manager_id){
        Optional<ManagerDTO> optionalManagerDTO =
                managerRepository.findManagerDTOByManager_id(manager_id);
        if(!optionalManagerDTO.isPresent()){
            return null;
        }
        ManagerDTO managerDTO = optionalManagerDTO.get();
        RESTfulUtility.addRestToManagerDTO(managerDTO);
        return managerDTO;
    }
}
