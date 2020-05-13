package org.yale.registry.research.services;

import org.locationtech.jts.geom.GeometryFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.ContactsDTO;
import org.yale.registry.research.entities.ContactsEntity;
import org.yale.registry.research.entities.TracingEntity;
import org.yale.registry.research.repositories.ContactsRepository;
import org.yale.registry.research.utilities.DTOUtility;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;

@Service
public class ContactsService {
    private ContactsRepository contactsRepository;
    private GeometryFactory geometryFactory;
    public static final int MAX_RANGE = 9000;

    @Autowired
    public ContactsService(ContactsRepository contactsRepository, GeometryFactory geometryFactory){
        this.contactsRepository = contactsRepository;
        this.geometryFactory = geometryFactory;
    }

    public ContactsDTO getContactDTOById(Long trace_id){
        Optional<ContactsEntity> optionalContactsEntity = contactsRepository.findById(trace_id);
        if(!optionalContactsEntity.isPresent()){
            return null;
        }
        ContactsEntity contactsEntity = optionalContactsEntity.get();
        return DTOUtility.contactsEntityToDTO(contactsEntity);
    }

    public List<ContactsDTO> getContactDTOsByName(String name){
        List<ContactsEntity> contactsEntities = contactsRepository.findContactsEntitiesByName(name);
        return DTOUtility.contactsDTOAggregator(contactsEntities);
    }
}
