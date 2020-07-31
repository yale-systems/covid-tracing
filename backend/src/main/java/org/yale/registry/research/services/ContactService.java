package org.yale.registry.research.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.ContactDTO;
import org.yale.registry.research.entities.ContactEntity;
import org.yale.registry.research.repositories.ContactRepository;
import org.yale.registry.research.utilities.RESTfulUtility;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ContactService {
    private ContactRepository contactRepository;

    @Autowired
    public ContactService(ContactRepository contactRepository){
        this.contactRepository = contactRepository;
    }

    public ContactDTO getContactDTOById(Long id){
        Optional<ContactEntity> optionalContactEntity =
                contactRepository.findContactEntityByContact_id(id);
        if(!optionalContactEntity.isPresent()){
            return null;
        }
        ContactDTO contactDTO = new ContactDTO(optionalContactEntity.get());
        RESTfulUtility.addRestToContactDTO(contactDTO);
        return contactDTO;
    }

    public List<ContactDTO> getContactDTOByPatientId(Long patient_id){
        List<ContactDTO> contactDTOS = new ArrayList<>();
        List<ContactEntity> contactEntities = contactRepository.findContactEntitiesByPatient_id(patient_id);
        for(ContactEntity contactEntity: contactEntities){
            contactDTOS.add(new ContactDTO(contactEntity));
        }
        RESTfulUtility.addRestToContactDTOs(contactDTOS);
        return contactDTOS;
    }

    public List<ContactDTO> getContactDTOByEventId(Long event_id){
        List<ContactDTO> contactDTOS = new ArrayList<>();
        List<ContactEntity> contactEntities = contactRepository.findContactEntitiesByEventId(event_id);
        for(ContactEntity contactEntity: contactEntities){
            contactDTOS.add(new ContactDTO(contactEntity));
        }
        RESTfulUtility.addRestToContactDTOs(contactDTOS);
        return contactDTOS;
    }

    public List<ContactDTO> getContactDTOForVolunteer(Long volunteer_id){
        List<ContactDTO> contactDTOS = new ArrayList<>();
        List<ContactEntity> contactEntities =
                contactRepository.findContactEntitiesForVolunteer(volunteer_id);
        for(ContactEntity contactEntity: contactEntities){
            contactDTOS.add(new ContactDTO(contactEntity));
        }
        RESTfulUtility.addRestToContactDTOs(contactDTOS);
        return contactDTOS;
    }

    public ContactDTO insert(ContactDTO contactDTO){
        ContactEntity contactEntity = new ContactEntity(contactDTO);
        contactRepository.save(contactEntity);
        ContactDTO returnContactDTO = new ContactDTO(contactEntity);
        RESTfulUtility.addRestToContactDTO(returnContactDTO);
        return returnContactDTO;
    }

    public ContactDTO update(ContactDTO contactDTO){
        Optional<ContactEntity> optionalContactEntity =
                contactRepository.findById(contactDTO.getContact_id());
        if(optionalContactEntity.isPresent()){
            ContactEntity contactEntity = optionalContactEntity.get();
            contactEntity.update(contactDTO);
            contactRepository.save(contactEntity);
            ContactDTO returnContactDTO = new ContactDTO(contactEntity);
            RESTfulUtility.addRestToContactDTO(returnContactDTO);
            return returnContactDTO;
        }
        return null;
    }
    public void delete(Long contact_id){
        contactRepository.deleteById(contact_id);
    }
}
