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

    public ContactDTO insert(ContactDTO contactDTO){
        ContactEntity contactEntity = new ContactEntity(
                contactDTO.getContact_id(), contactDTO.getFirst_name(),
                contactDTO.getLast_name(), contactDTO.getEmail(),
                contactDTO.getPhone_number(), contactDTO.getAge(),
                contactDTO.getHousehold(), contactDTO.getNature_of_contact(),
                contactDTO.getHealthcare_worker(), contactDTO.getPatient_id()
        );
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
            if(contactDTO.getFirst_name() != null){
                contactEntity.setFirst_name(contactDTO.getFirst_name());
            }
            if(contactDTO.getLast_name() != null){
                contactEntity.setLast_name(contactDTO.getLast_name());
            }
            if(contactDTO.getEmail() != null){
                contactEntity.setEmail(contactDTO.getEmail());
            }
            if(contactDTO.getPhone_number() != null){
                contactEntity.setPhone_number(contactDTO.getPhone_number());
            }
            if(contactDTO.getAge() != null){
                contactEntity.setAge(contactDTO.getAge());
            }
            if(contactDTO.getHousehold() != null){
                contactEntity.setHousehold(contactDTO.getHousehold());
            }
            if(contactDTO.getNature_of_contact() != null){
                contactEntity.setNature_of_contact(contactDTO.getNature_of_contact());
            }
            if(contactDTO.getHealthcare_worker() != null){
                contactEntity.setHealthcare_worker(contactDTO.getHealthcare_worker());
            }
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
