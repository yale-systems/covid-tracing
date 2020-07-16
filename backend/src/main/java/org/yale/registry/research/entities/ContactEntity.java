package org.yale.registry.research.entities;

import com.vladmihalcea.hibernate.type.array.ListArrayType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;
import org.yale.registry.research.DTOs.ContactDTO;
import org.yale.registry.research.enums.EnumTypes.AgeDemographic;
import org.yale.registry.research.enums.EnumTypes.ContactType;
import org.yale.registry.research.enums.EnumTypes.ContactCallStatus;
import org.yale.registry.research.enums.EnumTypes.Relationship;
import org.yale.registry.research.enums.EnumTypes.Language;
import org.yale.registry.research.enums.EnumTypes.Symptomatic;
import org.yale.registry.research.enums.EnumTypes.Symptom;
import org.yale.registry.research.enums.EnumTypes.SelfIsolate;
import org.yale.registry.research.enums.EnumTypes.Assistance;
import org.yale.registry.research.enums.PostgreSQLEnumType;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "contacts")
@TypeDef(
        name = "pgsql_enum",
        typeClass = PostgreSQLEnumType.class
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ContactEntity implements Serializable {
    @Id
    @SequenceGenerator(
            name = "contacts_generator",
            sequenceName = "contacts_contact_id_seq",
            allocationSize = 1
    )
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "contacts_generator")
    private Long contact_id;

    private String first_name;

    private String last_name;

    private String email;

    private String phone_number;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "age_demographic_t")
    @Type(type = "pgsql_enum")
    private AgeDemographic age_group;

    private Boolean household;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "contact_type_t")
    @Type(type = "pgsql_enum")
    private ContactType contact_type;

    private Integer times_called;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "contact_call_status_t")
    @Type(type = "pgsql_enum")
    private ContactCallStatus contact_call_status;

    @Temporal(TemporalType.TIMESTAMP)
    private Date contact_date;

    @Temporal(TemporalType.TIMESTAMP)
    private Date update_date;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "relationship_t")
    @Type(type = "pgsql_enum")
    private Relationship relationship;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "language_t")
    @Type(type = "pgsql_enum")
    private Language language;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "symptomatic_t")
    @Type(type = "pgsql_enum")
    private Symptomatic symptomatic;

    @Type(
            type = "com.vladmihalcea.hibernate.type.array.ListArrayType",
            parameters = {
                    @org.hibernate.annotations.Parameter(
                            name = ListArrayType.SQL_ARRAY_TYPE,
                            value = "symptom_t"
                    )
            }
    )
    @Column(columnDefinition = "symptom_t[]")
    private List<Symptom> symptoms;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "self_isolate_t")
    @Type(type = "pgsql_enum")
    private SelfIsolate self_isolate;

    @Type(
            type = "com.vladmihalcea.hibernate.type.array.ListArrayType",
            parameters = {
                    @org.hibernate.annotations.Parameter(
                            name = ListArrayType.SQL_ARRAY_TYPE,
                            value = "assistance_t"
                    )
            }
    )
    @Column(columnDefinition = "assistance_t[]")
    private List<Assistance> assistances;

    private String notes;

    private Boolean isolated_from_patient;

    private Boolean healthcare_worker;

    private Long patient_id;

    public ContactEntity(String first_name, String last_name,
                         String email, String phone_number, AgeDemographic age_group,
                         Boolean household, ContactType contact_type, Integer times_called,
                         ContactCallStatus contact_call_status, Date contact_date,
                         Date update_date, Relationship relationship, Language language,
                         Symptomatic symptomatic, List<Symptom> symptoms, SelfIsolate self_isolate,
                         List<Assistance> assistances, String notes, Boolean isolated_from_patient, Boolean healthcare_worker, Long patient_id) {
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
    }

    public ContactEntity(ContactDTO contactDTO){
        this.contact_id = contactDTO.getContact_id();
        this.first_name = contactDTO.getFirst_name();
        this.last_name = contactDTO.getLast_name();
        this.email = contactDTO.getEmail();
        this.phone_number = contactDTO.getPhone_number();
        this.age_group = contactDTO.getAge_group();
        this.household = contactDTO.getHousehold();
        this.contact_type = contactDTO.getContact_type();
        this.times_called = contactDTO.getTimes_called();
        this.contact_call_status = contactDTO.getContact_call_status();
        this.contact_date = contactDTO.getContact_date();
        this.update_date = contactDTO.getUpdate_date();
        this.relationship = contactDTO.getRelationship();
        this.language = contactDTO.getLanguage();
        this.symptomatic = contactDTO.getSymptomatic();
        this.symptoms = contactDTO.getSymptoms();
        this.self_isolate = contactDTO.getSelf_isolate();
        this.assistances = contactDTO.getAssistances();
        this.notes = contactDTO.getNotes();
        this.isolated_from_patient = contactDTO.getIsolated_from_patient();
        this.healthcare_worker = contactDTO.getHealthcare_worker();
        this.patient_id = contactDTO.getPatient_id();
    }

    public void update(ContactDTO contactDTO){
        this.first_name = contactDTO.getFirst_name();
        this.last_name = contactDTO.getLast_name();
        this.email = contactDTO.getEmail();
        this.phone_number = contactDTO.getPhone_number();
        this.age_group = contactDTO.getAge_group();
        this.household = contactDTO.getHousehold();
        this.contact_type = contactDTO.getContact_type();
        this.times_called = contactDTO.getTimes_called();
        this.contact_call_status = contactDTO.getContact_call_status();
        this.contact_date = contactDTO.getContact_date();
        this.update_date = contactDTO.getUpdate_date();
        this.relationship = contactDTO.getRelationship();
        this.language = contactDTO.getLanguage();
        this.symptomatic = contactDTO.getSymptomatic();
        this.symptoms = contactDTO.getSymptoms();
        this.self_isolate = contactDTO.getSelf_isolate();
        this.assistances = contactDTO.getAssistances();
        this.notes = contactDTO.getNotes();
        this.isolated_from_patient = contactDTO.getIsolated_from_patient();
        this.healthcare_worker = contactDTO.getHealthcare_worker();
        this.patient_id = contactDTO.getPatient_id();
    }
}
