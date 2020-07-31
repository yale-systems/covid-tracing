package org.yale.registry.research.DTOs;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.entities.ContactEntity;
import org.yale.registry.research.enums.EnumTypes.AgeDemographic;
import org.yale.registry.research.enums.EnumTypes.ContactType;
import org.yale.registry.research.enums.EnumTypes.ContactCallStatus;
import org.yale.registry.research.enums.EnumTypes.Relationship;
import org.yale.registry.research.enums.EnumTypes.Language;
import org.yale.registry.research.enums.EnumTypes.Symptomatic;
import org.yale.registry.research.enums.EnumTypes.Symptom;
import org.yale.registry.research.enums.EnumTypes.SelfIsolate;
import org.yale.registry.research.enums.EnumTypes.Assistance;
import org.yale.registry.research.utilities.EnumMapUtility;

import javax.persistence.*;
import java.util.*;

@Getter
@Setter
@NoArgsConstructor
public class ContactDTO extends RepresentationModel<ContactDTO> {
    private Long contact_id;

    private String first_name;

    private String last_name;

    private String email;

    private String phone_number;

    private AgeDemographic age_group;

    private Boolean household;

    private ContactType contact_type;

    private Integer times_called;

    private ContactCallStatus contact_call_status;

    private Date contact_date;

    private Date update_date;

    private Relationship relationship;

    private Language language;

    private Symptomatic symptomatic;

    private List<Symptom> symptoms;

    private SelfIsolate self_isolate;

    private List<Assistance> assistances;

    private String notes;

    private Boolean isolated_from_patient;

    private Boolean healthcare_worker;

    private Long patient_id;

    private Map<String, Map<String, Integer>> enums;

    public ContactDTO(Long contact_id, String first_name, String last_name,
                      String email, String phone_number, AgeDemographic age_group,
                      Boolean household, ContactType contact_type, Integer times_called,
                      ContactCallStatus contact_call_status, Date contact_date,
                      Date update_date, Relationship relationship, Language language,
                      Symptomatic symptomatic, List<Symptom> symptoms, SelfIsolate self_isolate,
                      List<Assistance> assistances, String notes, Boolean isolated_from_patient,
                      Boolean healthcare_worker, Long patient_id) {
        this.contact_id = contact_id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.phone_number = phone_number;
        this.age_group = age_group;
        this.household = household;
        this.contact_type = contact_type;
        this.times_called = times_called;
        this.contact_call_status = contact_call_status;
        this.contact_date = contact_date;
        this.update_date = update_date;
        this.relationship = relationship;
        this.language = language;
        this.symptomatic = symptomatic;
        this.symptoms = symptoms;
        this.self_isolate = self_isolate;
        this.assistances = assistances;
        this.notes = notes;
        this.isolated_from_patient = isolated_from_patient;
        this.healthcare_worker = healthcare_worker;
        this.patient_id = patient_id;
        this.enums = EnumMapUtility.generateEnumMap(Arrays.asList(AgeDemographic.class, ContactType.class,
                ContactCallStatus.class, Relationship.class, Language.class, Symptomatic.class, Symptom.class,
                SelfIsolate.class, Assistance.class));
    }

    public ContactDTO(String first_name, String last_name,
                      String email, String phone_number, AgeDemographic age_group,
                      Boolean household, ContactType contact_type, Integer times_called,
                      ContactCallStatus contact_call_status, Date contact_date,
                      Date update_date, Relationship relationship, Language language,
                      Symptomatic symptomatic, List<Symptom> symptoms, SelfIsolate self_isolate,
                      List<Assistance> assistances, String notes, Boolean isolated_from_patient,
                      Boolean healthcare_worker, Long patient_id) {
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.phone_number = phone_number;
        this.age_group = age_group;
        this.household = household;
        this.contact_type = contact_type;
        this.times_called = times_called;
        this.contact_call_status = contact_call_status;
        this.contact_date = contact_date;
        this.update_date = update_date;
        this.relationship = relationship;
        this.language = language;
        this.symptomatic = symptomatic;
        this.symptoms = symptoms;
        this.self_isolate = self_isolate;
        this.assistances = assistances;
        this.notes = notes;
        this.isolated_from_patient = isolated_from_patient;
        this.healthcare_worker = healthcare_worker;
        this.patient_id = patient_id;
        this.enums = EnumMapUtility.generateEnumMap(Arrays.asList(AgeDemographic.class, ContactType.class,
                ContactCallStatus.class, Relationship.class, Language.class, Symptomatic.class, Symptom.class,
                SelfIsolate.class, Assistance.class));
    }

    public ContactDTO(ContactEntity contactEntity) {
        this.contact_id = contactEntity.getContact_id();
        this.first_name = contactEntity.getFirst_name();
        this.last_name = contactEntity.getLast_name();
        this.email = contactEntity.getEmail();
        this.phone_number = contactEntity.getPhone_number();
        this.age_group = contactEntity.getAge_group();
        this.household = contactEntity.getHousehold();
        this.contact_type = contactEntity.getContact_type();
        this.times_called = contactEntity.getTimes_called();
        this.contact_call_status = contactEntity.getContact_call_status();
        this.contact_date = contactEntity.getContact_date();
        this.update_date = contactEntity.getUpdate_date();
        this.relationship = contactEntity.getRelationship();
        this.language = contactEntity.getLanguage();
        this.symptomatic = contactEntity.getSymptomatic();
        this.symptoms = contactEntity.getSymptoms();
        this.self_isolate = contactEntity.getSelf_isolate();
        this.assistances = contactEntity.getAssistances();
        this.notes = contactEntity.getNotes();
        this.isolated_from_patient = contactEntity.getIsolated_from_patient();
        this.healthcare_worker = contactEntity.getHealthcare_worker();
        this.patient_id = contactEntity.getPatient_id();
        this.enums = EnumMapUtility.generateEnumMap(Arrays.asList(AgeDemographic.class, ContactType.class,
                ContactCallStatus.class, Relationship.class, Language.class, Symptomatic.class, Symptom.class,
                SelfIsolate.class, Assistance.class));
    }
}
