package org.yale.registry.research.entities;

import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;
import org.yale.registry.research.DTOs.ContactDTO;
import org.yale.registry.research.enums.EnumTypes.AgeDemographic;
import org.yale.registry.research.enums.EnumTypes.ContactType;
import org.yale.registry.research.enums.EnumTypes.ContactCallStatus;
import org.yale.registry.research.enums.EnumTypes.Relationship;
import org.yale.registry.research.enums.EnumTypes.Language;
import org.yale.registry.research.enums.EnumTypes.Symptomatic;
import org.yale.registry.research.enums.EnumTypes.SelfIsolate;
import org.yale.registry.research.enums.PostgreSQLEnumType;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "contacts")
@TypeDef(
        name = "pgsql_enum",
        typeClass = PostgreSQLEnumType.class
)
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

    // TODO: ADD ARRAY ENUM symptoms

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "self_isolate_t")
    @Type(type = "pgsql_enum")
    private SelfIsolate self_isolate;

    // TODO: ADD ARRAY ENUM assistance

    private String notes;

    private Boolean isolated_from_patient;

    private Boolean healthcare_worker;

    private Long patient_id;

    public ContactEntity(){}

    public ContactEntity(Long contact_id, String first_name, String last_name,
                         String email, String phone_number, AgeDemographic age_group,
                         Boolean household, ContactType contact_type, Integer times_called,
                         ContactCallStatus contact_call_status, Date contact_date,
                         Date update_date, Relationship relationship, Language language,
                         Symptomatic symptomatic, SelfIsolate self_isolate, String notes,
                         Boolean isolated_from_patient, Boolean healthcare_worker, Long patient_id) {
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
        this.self_isolate = self_isolate;
        this.notes = notes;
        this.isolated_from_patient = isolated_from_patient;
        this.healthcare_worker = healthcare_worker;
        this.patient_id = patient_id;
    }

    public ContactEntity(String first_name, String last_name,
                         String email, String phone_number, AgeDemographic age_group,
                         Boolean household, ContactType contact_type, Integer times_called,
                         ContactCallStatus contact_call_status, Date contact_date,
                         Date update_date, Relationship relationship, Language language,
                         Symptomatic symptomatic, SelfIsolate self_isolate, String notes,
                         Boolean isolated_from_patient, Boolean healthcare_worker, Long patient_id) {
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
        this.self_isolate = self_isolate;
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
        this.self_isolate = contactDTO.getSelf_isolate();
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
        this.self_isolate = contactDTO.getSelf_isolate();
        this.notes = contactDTO.getNotes();
        this.isolated_from_patient = contactDTO.getIsolated_from_patient();
        this.healthcare_worker = contactDTO.getHealthcare_worker();
        this.patient_id = contactDTO.getPatient_id();
    }

    public Long getContact_id() {
        return contact_id;
    }

    public void setContact_id(Long contact_id) {
        this.contact_id = contact_id;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public AgeDemographic getAge_group() {
        return age_group;
    }

    public void setAge_group(AgeDemographic age_group) {
        this.age_group = age_group;
    }

    public Boolean getHousehold() {
        return household;
    }

    public void setHousehold(Boolean household) {
        this.household = household;
    }

    public ContactType getContact_type() {
        return contact_type;
    }

    public void setContact_type(ContactType contact_type) {
        this.contact_type = contact_type;
    }

    public Integer getTimes_called() {
        return times_called;
    }

    public void setTimes_called(Integer times_called) {
        this.times_called = times_called;
    }

    public ContactCallStatus getContact_call_status() {
        return contact_call_status;
    }

    public void setContact_call_status(ContactCallStatus contact_call_status) {
        this.contact_call_status = contact_call_status;
    }

    public Date getContact_date() {
        return contact_date;
    }

    public void setContact_date(Date contact_date) {
        this.contact_date = contact_date;
    }

    public Date getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(Date update_date) {
        this.update_date = update_date;
    }

    public Relationship getRelationship() {
        return relationship;
    }

    public void setRelationship(Relationship relationship) {
        this.relationship = relationship;
    }

    public Language getLanguage() {
        return language;
    }

    public void setLanguage(Language language) {
        this.language = language;
    }

    public Symptomatic getSymptomatic() {
        return symptomatic;
    }

    public void setSymptomatic(Symptomatic symptomatic) {
        this.symptomatic = symptomatic;
    }

    public SelfIsolate getSelf_isolate() {
        return self_isolate;
    }

    public void setSelf_isolate(SelfIsolate self_isolate) {
        this.self_isolate = self_isolate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Boolean getIsolated_from_patient() {
        return isolated_from_patient;
    }

    public void setIsolated_from_patient(Boolean isolated_from_patient) {
        this.isolated_from_patient = isolated_from_patient;
    }

    public Boolean getHealthcare_worker() {
        return healthcare_worker;
    }

    public void setHealthcare_worker(Boolean healthcare_worker) {
        this.healthcare_worker = healthcare_worker;
    }

    public Long getPatient_id() {
        return patient_id;
    }

    public void setPatient_id(Long patient_id) {
        this.patient_id = patient_id;
    }
}
