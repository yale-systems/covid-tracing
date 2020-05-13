package org.yale.registry.research.repositories;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.yale.registry.research.entities.ContactsEntity;

import java.util.List;

public interface ContactsRepository extends PagingAndSortingRepository<ContactsEntity, Long> {
    List<ContactsEntity> findContactsEntitiesByName(String name);
}
