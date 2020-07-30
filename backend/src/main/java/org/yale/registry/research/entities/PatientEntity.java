package org.yale.registry.research.entities;

import com.vladmihalcea.hibernate.type.array.ListArrayType;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;
import org.locationtech.jts.geom.Point;
import org.yale.registry.research.DTOs.PatientDTO;
import org.yale.registry.research.enums.EnumTypes.ReasonFlagged;
import org.yale.registry.research.enums.EnumTypes.Language;
import org.yale.registry.research.enums.EnumTypes.CaseCallStatus;
import org.yale.registry.research.enums.EnumTypes.SawDoctor;
import org.yale.registry.research.enums.EnumTypes.Insurance;
import org.yale.registry.research.enums.EnumTypes.Symptom;
import org.yale.registry.research.enums.EnumTypes.Gender;
import org.yale.registry.research.enums.EnumTypes.Race;
import org.yale.registry.research.enums.EnumTypes.SelfIsolate;
import org.yale.registry.research.enums.EnumTypes.PreexistingCondition;
import org.yale.registry.research.enums.EnumTypes.Employment;
import org.yale.registry.research.enums.EnumTypes.SuspectedExposure;
import org.yale.registry.research.enums.EnumTypes.Assistance;
import org.yale.registry.research.enums.EnumTypes.Symptomatic;
import org.yale.registry.research.enums.PostgreSQLEnumType;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "patients")
@TypeDef(
        name = "pgsql_enum",
        typeClass = PostgreSQLEnumType.class
)
public class PatientEntity implements Serializable {
    @Id
    @SequenceGenerator(name = "patients_generator", sequenceName = "patients_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "patients_generator")
    private Long patient_id;

    private String username;

    private String password;

    private String first_name;

    private String last_name;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "language_t")
    @Type(type = "pgsql_enum")
    private Language language;

    @Temporal(TemporalType.TIMESTAMP)
    private Date diagnosis_date;

    @Temporal(TemporalType.TIMESTAMP)
    private Date onset_date;

    @Temporal(TemporalType.TIMESTAMP)
    private Date last_worked_date;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "case_call_status_t")
    @Type(type = "pgsql_enum")
    private CaseCallStatus case_call_status;

    private Boolean travelled;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "saw_doctor_t")
    @Type(type = "pgsql_enum")
    private SawDoctor saw_doctor;

    private Boolean knows_status;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "insurance_t")
    @Type(type = "pgsql_enum")
    private Insurance insurance;

    private Long times_called;

    private String phone_number;

    private Boolean symptomatic;

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
    @Column(columnDefinition = "gender_t")
    @Type(type = "pgsql_enum")
    private Gender gender;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "race_t")
    @Type(type = "pgsql_enum")
    private Race race;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "self_isolate_t")
    @Type(type = "pgsql_enum")
    private SelfIsolate self_isolate;

    @Type(
            type = "com.vladmihalcea.hibernate.type.array.ListArrayType",
            parameters = {
                    @org.hibernate.annotations.Parameter(
                            name = ListArrayType.SQL_ARRAY_TYPE,
                            value = "preexisting_condition_t"
                    )
            }
    )
    @Column(columnDefinition = "preexisting_condition_t[]")
    private List<PreexistingCondition> preexisting_conditions;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "employment_t")
    @Type(type = "pgsql_enum")
    private Employment employment;

    @Type(
            type = "com.vladmihalcea.hibernate.type.array.ListArrayType",
            parameters = {
                    @org.hibernate.annotations.Parameter(
                            name = ListArrayType.SQL_ARRAY_TYPE,
                            value = "suspected_exposure_t"
                    )
            }
    )
    @Column(columnDefinition = "suspected_exposure_t[]")
    private List<SuspectedExposure> suspected_exposures;

    private Point home_location;

    private Boolean housing_insecure;

    private String shelter_name;

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

    @Temporal(TemporalType.TIMESTAMP)
    private Date date_of_birth;

    private Boolean referral;

    private Boolean flagged;

    @Type(
            type = "com.vladmihalcea.hibernate.type.array.ListArrayType",
            parameters = {
                    @org.hibernate.annotations.Parameter(
                            name = ListArrayType.SQL_ARRAY_TYPE,
                            value = "reason_flagged_t"
                    )
            }
    )
    @Column(columnDefinition = "reason_flagged_t[]")
    private List<ReasonFlagged> reasons_flagged;

    private Boolean requested_interview;

    private String notes;

    private String email;

    private Long manager_id;

    private Long volunteer_id;


    public PatientEntity(){}

    public PatientEntity(Long patient_id, String username, String password, String first_name, String last_name, Language language, Date diagnosis_date, Date onset_date, Date last_worked_date, CaseCallStatus case_call_status, Boolean travelled, SawDoctor saw_doctor, Boolean knows_status, Insurance insurance, Long times_called, String phone_number, Boolean symptomatic, List<Symptom> symptoms, Gender gender, Race race, SelfIsolate self_isolate, List<PreexistingCondition> preexisting_conditions, Employment employment, List<SuspectedExposure> suspected_exposures, Point home_location, Boolean housing_insecure, String shelter_name, List<Assistance> assistances, Date date_of_birth, Boolean referral, Boolean flagged, List<ReasonFlagged> reasons_flagged, Boolean requested_interview, String notes, String email, Long manager_id, Long volunteer_id) {
        this.patient_id = patient_id;
        this.username = username;
        this.password = password;
        this.first_name = first_name;
        this.last_name = last_name;
        this.language = language;
        this.diagnosis_date = diagnosis_date;
        this.onset_date = onset_date;
        this.last_worked_date = last_worked_date;
        this.case_call_status = case_call_status;
        this.travelled = travelled;
        this.saw_doctor = saw_doctor;
        this.knows_status = knows_status;
        this.insurance = insurance;
        this.times_called = times_called;
        this.phone_number = phone_number;
        this.symptomatic = symptomatic;
        this.symptoms = symptoms;
        this.gender = gender;
        this.race = race;
        this.self_isolate = self_isolate;
        this.preexisting_conditions = preexisting_conditions;
        this.employment = employment;
        this.suspected_exposures = suspected_exposures;
        this.home_location = home_location;
        this.housing_insecure = housing_insecure;
        this.shelter_name = shelter_name;
        this.assistances = assistances;
        this.date_of_birth = date_of_birth;
        this.referral = referral;
        this.flagged = flagged;
        this.reasons_flagged = reasons_flagged;
        this.requested_interview = requested_interview;
        this.notes = notes;
        this.email = email;
        this.manager_id = manager_id;
        this.volunteer_id = volunteer_id;
    }

    public PatientEntity(String username, String password, String first_name,
                         String last_name, Language language, Date diagnosis_date,
                         Date onset_date, Date last_worked_date, CaseCallStatus case_call_status,
                         Boolean travelled, SawDoctor saw_doctor, Boolean knows_status,
                         Insurance insurance, Long times_called, String phone_number,
                         Boolean symptomatic, List<Symptom> symptoms, Gender gender,
                         Race race, SelfIsolate self_isolate, List<PreexistingCondition> preexisting_conditions,
                         Employment employment, List<SuspectedExposure> suspected_exposures,
                         Point home_location, Boolean housing_insecure, String shelter_name,
                         List<Assistance> assistances, Date date_of_birth, Boolean referral,
                         Boolean flagged, List<ReasonFlagged> reasons_flagged, Boolean requested_interview,
                         String notes, String email, Long manager_id, Long volunteer_id) {
        this.username = username;
        this.password = password;
        this.first_name = first_name;
        this.last_name = last_name;
        this.language = language;
        this.diagnosis_date = diagnosis_date;
        this.onset_date = onset_date;
        this.last_worked_date = last_worked_date;
        this.case_call_status = case_call_status;
        this.travelled = travelled;
        this.saw_doctor = saw_doctor;
        this.knows_status = knows_status;
        this.insurance = insurance;
        this.times_called = times_called;
        this.phone_number = phone_number;
        this.symptomatic = symptomatic;
        this.symptoms = symptoms;
        this.gender = gender;
        this.race = race;
        this.self_isolate = self_isolate;
        this.preexisting_conditions = preexisting_conditions;
        this.employment = employment;
        this.suspected_exposures = suspected_exposures;
        this.home_location = home_location;
        this.housing_insecure = housing_insecure;
        this.shelter_name = shelter_name;
        this.assistances = assistances;
        this.date_of_birth = date_of_birth;
        this.referral = referral;
        this.flagged = flagged;
        this.reasons_flagged = reasons_flagged;
        this.requested_interview = requested_interview;
        this.notes = notes;
        this.email = email;
        this.manager_id = manager_id;
        this.volunteer_id = volunteer_id;
    }

    public PatientEntity(PatientDTO patientDTO) {
        this.patient_id = patientDTO.getPatient_id();
        this.username = patientDTO.getUsername();
        this.password = patientDTO.getPassword();
        this.first_name = patientDTO.getFirst_name();
        this.last_name = patientDTO.getLast_name();
        this.language = patientDTO.getLanguage();
        this.diagnosis_date = patientDTO.getDiagnosis_date();
        this.onset_date = patientDTO.getOnset_date();
        this.last_worked_date = patientDTO.getLast_worked_date();
        this.case_call_status = patientDTO.getCase_call_status();
        this.travelled = patientDTO.getTravelled();
        this.saw_doctor = patientDTO.getSaw_doctor();
        this.knows_status = patientDTO.getKnows_status();
        this.insurance = patientDTO.getInsurance();
        this.times_called = patientDTO.getTimes_called();
        this.phone_number = patientDTO.getPhone_number();
        this.symptomatic = patientDTO.getSymptomatic();
        this.symptoms = patientDTO.getSymptoms();
        this.gender = patientDTO.getGender();
        this.race = patientDTO.getRace();
        this.self_isolate = patientDTO.getSelf_isolate();
        this.preexisting_conditions = patientDTO.getPreexisting_conditions();
        this.employment = patientDTO.getEmployment();
        this.suspected_exposures = patientDTO.getSuspected_exposures();
        this.home_location = patientDTO.getHome_location();
        this.housing_insecure = patientDTO.getHousing_insecure();
        this.shelter_name = patientDTO.getShelter_name();
        this.assistances = patientDTO.getAssistances();
        this.date_of_birth = patientDTO.getDate_of_birth();
        this.referral = patientDTO.getReferral();
        this.flagged = patientDTO.getFlagged();
        this.reasons_flagged = patientDTO.getReasons_flagged();
        this.requested_interview = patientDTO.getRequested_interview();
        this.notes = patientDTO.getNotes();
        this.email = patientDTO.getEmail();
        this.manager_id = patientDTO.getManager_id();
        this.volunteer_id = patientDTO.getVolunteer_id();
    }


    public void update(PatientDTO patientDTO){
        this.patient_id = patientDTO.getPatient_id();
        this.username = patientDTO.getUsername();
        this.password = patientDTO.getPassword();
        this.first_name = patientDTO.getFirst_name();
        this.last_name = patientDTO.getLast_name();
        this.language = patientDTO.getLanguage();
        this.diagnosis_date = patientDTO.getDiagnosis_date();
        this.onset_date = patientDTO.getOnset_date();
        this.last_worked_date = patientDTO.getLast_worked_date();
        this.case_call_status = patientDTO.getCase_call_status();
        this.travelled = patientDTO.getTravelled();
        this.saw_doctor = patientDTO.getSaw_doctor();
        this.knows_status = patientDTO.getKnows_status();
        this.insurance = patientDTO.getInsurance();
        this.times_called = patientDTO.getTimes_called();
        this.phone_number = patientDTO.getPhone_number();
        this.symptomatic = patientDTO.getSymptomatic();
        this.symptoms = patientDTO.getSymptoms();
        this.gender = patientDTO.getGender();
        this.race = patientDTO.getRace();
        this.self_isolate = patientDTO.getSelf_isolate();
        this.preexisting_conditions = patientDTO.getPreexisting_conditions();
        this.employment = patientDTO.getEmployment();
        this.suspected_exposures = patientDTO.getSuspected_exposures();
        this.home_location = patientDTO.getHome_location();
        this.housing_insecure = patientDTO.getHousing_insecure();
        this.shelter_name = patientDTO.getShelter_name();
        this.assistances = patientDTO.getAssistances();
        this.date_of_birth = patientDTO.getDate_of_birth();
        this.referral = patientDTO.getReferral();
        this.flagged = patientDTO.getFlagged();
        this.reasons_flagged = patientDTO.getReasons_flagged();
        this.requested_interview = patientDTO.getRequested_interview();
        this.notes = patientDTO.getNotes();
        this.email = patientDTO.getEmail();
        this.manager_id = patientDTO.getManager_id();
        this.volunteer_id = patientDTO.getVolunteer_id();
    }

    public Long getPatient_id() {
        return patient_id;
    }

    public void setPatient_id(Long patient_id) {
        this.patient_id = patient_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public Language getLanguage() {
        return language;
    }

    public void setLanguage(Language language) {
        this.language = language;
    }

    public Date getDiagnosis_date() {
        return diagnosis_date;
    }

    public void setDiagnosis_date(Date diagnosis_date) {
        this.diagnosis_date = diagnosis_date;
    }

    public Date getOnset_date() {
        return onset_date;
    }

    public void setOnset_date(Date onset_date) {
        this.onset_date = onset_date;
    }

    public Date getLast_worked_date() {
        return last_worked_date;
    }

    public void setLast_worked_date(Date last_worked_date) {
        this.last_worked_date = last_worked_date;
    }

    public CaseCallStatus getCase_call_status() {
        return case_call_status;
    }

    public void setCase_call_status(CaseCallStatus case_call_status) {
        this.case_call_status = case_call_status;
    }

    public Boolean getTravelled() {
        return travelled;
    }

    public void setTravelled(Boolean travelled) {
        this.travelled = travelled;
    }

    public SawDoctor getSaw_doctor() {
        return saw_doctor;
    }

    public void setSaw_doctor(SawDoctor saw_doctor) {
        this.saw_doctor = saw_doctor;
    }

    public Boolean getKnows_status() {
        return knows_status;
    }

    public void setKnows_status(Boolean knows_status) {
        this.knows_status = knows_status;
    }

    public Insurance getInsurance() {
        return insurance;
    }

    public void setInsurance(Insurance insurance) {
        this.insurance = insurance;
    }

    public Long getTimes_called() {
        return times_called;
    }

    public void setTimes_called(Long times_called) {
        this.times_called = times_called;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public Boolean getSymptomatic() {
        return symptomatic;
    }

    public void setSymptomatic(Boolean symptomatic) {
        this.symptomatic = symptomatic;
    }

    public List<Symptom> getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(List<Symptom> symptoms) {
        this.symptoms = symptoms;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public Race getRace() {
        return race;
    }

    public void setRace(Race race) {
        this.race = race;
    }

    public SelfIsolate getSelf_isolate() {
        return self_isolate;
    }

    public void setSelf_isolate(SelfIsolate self_isolate) {
        this.self_isolate = self_isolate;
    }

    public List<PreexistingCondition> getPreexisting_conditions() {
        return preexisting_conditions;
    }

    public void setPreexisting_conditions(List<PreexistingCondition> preexisting_conditions) {
        this.preexisting_conditions = preexisting_conditions;
    }

    public Employment getEmployment() {
        return employment;
    }

    public void setEmployment(Employment employment) {
        this.employment = employment;
    }

    public List<SuspectedExposure> getSuspected_exposures() {
        return suspected_exposures;
    }

    public void setSuspected_exposures(List<SuspectedExposure> suspected_exposures) {
        this.suspected_exposures = suspected_exposures;
    }

    public Point getHome_location() {
        return home_location;
    }

    public void setHome_location(Point home_location) {
        this.home_location = home_location;
    }

    public Boolean getHousing_insecure() {
        return housing_insecure;
    }

    public void setHousing_insecure(Boolean housing_insecure) {
        this.housing_insecure = housing_insecure;
    }

    public String getShelter_name() {
        return shelter_name;
    }

    public void setShelter_name(String shelter_name) {
        this.shelter_name = shelter_name;
    }

    public List<Assistance> getAssistances() {
        return assistances;
    }

    public void setAssistances(List<Assistance> assistances) {
        this.assistances = assistances;
    }

    public Date getDate_of_birth() {
        return date_of_birth;
    }

    public void setDate_of_birth(Date date_of_birth) {
        this.date_of_birth = date_of_birth;
    }

    public Boolean getReferral() {
        return referral;
    }

    public void setReferral(Boolean referral) {
        this.referral = referral;
    }

    public Boolean getFlagged() {
        return flagged;
    }

    public void setFlagged(Boolean flagged) {
        this.flagged = flagged;
    }

    public List<ReasonFlagged> getReasons_flagged() {
        return reasons_flagged;
    }

    public void setReasons_flagged(List<ReasonFlagged> reasons_flagged) {
        this.reasons_flagged = reasons_flagged;
    }

    public Boolean getRequested_interview() {
        return requested_interview;
    }

    public void setRequested_interview(Boolean requested_interview) {
        this.requested_interview = requested_interview;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Long getManager_id() {
        return manager_id;
    }

    public void setManager_id(Long manager_id) {
        this.manager_id = manager_id;
    }

    public Long getVolunteer_id() {
        return volunteer_id;
    }

    public void setVolunteer_id(Long volunteer_id) {
        this.volunteer_id = volunteer_id;
    }
}
