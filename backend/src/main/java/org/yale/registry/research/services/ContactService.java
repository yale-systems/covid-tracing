package org.yale.registry.research.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yale.registry.research.DTOs.ContactDTO;
import org.yale.registry.research.entities.ContactEntity;
import org.yale.registry.research.repositories.ContactRepository;
import org.yale.registry.research.utilities.RESTfulUtility;

import javax.transaction.Transactional;
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
        Optional<ContactDTO> optionalContactDTO =
                contactRepository.findContactDTOByContact_id(id);
        if(!optionalContactDTO.isPresent()){
            return null;
        }
        ContactDTO contactDTO = optionalContactDTO.get();
        RESTfulUtility.addRestToContactDTO(contactDTO);
        return contactDTO;
    }

    public List<ContactDTO> getContactDTOByPatientId(Long patient_id){
        List<ContactDTO> contactDTOS = contactRepository.findContactDTOsByPatient_id(patient_id);
        RESTfulUtility.addRestToContactDTOs(contactDTOS);
        return contactDTOS;
    }

    public List<ContactDTO> getContactDTOByEventId(Long event_id){
        List<ContactDTO> contactDTOS = contactRepository.findContactDTOsByEventId(event_id);
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
