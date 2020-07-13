package org.yale.registry.research.DTOs;

import com.bedatadriven.jackson.datatype.jts.serialization.GeometryDeserializer;
import com.bedatadriven.jackson.datatype.jts.serialization.GeometrySerializer;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import org.locationtech.jts.geom.Point;
import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.entities.PatientEntity;
import org.yale.registry.research.enums.EnumTypes.Language;
import org.yale.registry.research.enums.EnumTypes.CaseCallStatus;
import org.yale.registry.research.enums.EnumTypes.SawDoctor;
import org.yale.registry.research.enums.EnumTypes.Insurance;
import org.yale.registry.research.enums.EnumTypes.Symptomatic;
import org.yale.registry.research.enums.EnumTypes.Gender;
import org.yale.registry.research.enums.EnumTypes.Race;
import org.yale.registry.research.enums.EnumTypes.SelfIsolate;
import org.yale.registry.research.enums.EnumTypes.Employment;

import javax.persistence.*;
import java.util.Date;

public class PatientDTO extends RepresentationModel<PatientDTO> {
    private Long patient_id;

    private String username;

    private String password;

    private String first_name;

    private String last_name;

    private Language language;

    private Date diagnosis_date;

    private Date onset_date;

    private Date last_worked_date;

    private CaseCallStatus case_call_status;

    private Boolean travelled;

    private SawDoctor saw_doctor;

    private Boolean knows_status;

    private Insurance insurance;

    private Long times_called;

    private Long phone_number;

    private Symptomatic symptomatic;

    // TODO: MAKE ARRAY ENUM SYMPTOMS

    private Gender gender;

    private Race race;

    private SelfIsolate self_isolate;

    // TODO: MAKE ARRAY ENUM PREEXISTING_CONDITIONS

    private Employment employment;

    // TODO: MAKE ARRAY ENUM SUSPECTED_EXPOSURE

    @JsonSerialize(using = GeometrySerializer.class)
    @JsonDeserialize(using = GeometryDeserializer.class)
    private Point home_location;

    private Boolean housing_insecure;

    private String shelter_name;

    // TODO: MAKE ARRAY ENUM ASSISTANCE

    @Temporal(TemporalType.TIMESTAMP)
    private Date date_of_birth;

    private Boolean referral;

    private Boolean flagged;

    // TODO: MAKE ARRAY ENUM REASONS_FLAGGED

    private Boolean requested_interview;

    private String notes;

    private String email;

    private Long manager_id;

    private Long volunteer_id;


    public PatientDTO(){}

    public PatientDTO(Long patient_id, String username, String password,
                         String first_name, String last_name, Language language,
                         Date diagnosis_date, Date onset_date, Date last_worked_date,
                         CaseCallStatus case_call_status, Boolean travelled, SawDoctor saw_doctor,
                         Boolean knows_status, Insurance insurance, Long times_called,
                         Long phone_number, Symptomatic symptomatic, Gender gender,
                         Race race, SelfIsolate self_isolate, Employment employment,
                         Point home_location, Boolean housing_insecure, String shelter_name,
                         Date date_of_birth, Boolean referral, Boolean flagged,
                         Boolean requested_interview, String notes, String email,
                         Long manager_id, Long volunteer_id) {
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
        this.gender = gender;
        this.race = race;
        this.self_isolate = self_isolate;
        this.employment = employment;
        this.home_location = home_location;
        this.housing_insecure = housing_insecure;
        this.shelter_name = shelter_name;
        this.date_of_birth = date_of_birth;
        this.referral = referral;
        this.flagged = flagged;
        this.requested_interview = requested_interview;
        this.notes = notes;
        this.email = email;
        this.manager_id = manager_id;
        this.volunteer_id = volunteer_id;
    }


    public PatientDTO(String username, String password,
                         String first_name, String last_name, Language language,
                         Date diagnosis_date, Date onset_date, Date last_worked_date,
                         CaseCallStatus case_call_status, Boolean travelled, SawDoctor saw_doctor,
                         Boolean knows_status, Insurance insurance, Long times_called,
                         Long phone_number, Symptomatic symptomatic, Gender gender,
                         Race race, SelfIsolate self_isolate, Employment employment,
                         Point home_location, Boolean housing_insecure, String shelter_name,
                         Date date_of_birth, Boolean referral, Boolean flagged,
                         Boolean requested_interview, String notes, String email,
                         Long manager_id, Long volunteer_id) {
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
        this.gender = gender;
        this.race = race;
        this.self_isolate = self_isolate;
        this.employment = employment;
        this.home_location = home_location;
        this.housing_insecure = housing_insecure;
        this.shelter_name = shelter_name;
        this.date_of_birth = date_of_birth;
        this.referral = referral;
        this.flagged = flagged;
        this.requested_interview = requested_interview;
        this.notes = notes;
        this.email = email;
        this.manager_id = manager_id;
        this.volunteer_id = volunteer_id;
    }

    public PatientDTO(PatientEntity patientEntity) {
        this.patient_id = patientEntity.getPatient_id();
        this.username = patientEntity.getUsername();
        this.password = patientEntity.getPassword();
        this.first_name = patientEntity.getFirst_name();
        this.last_name = patientEntity.getLast_name();
        this.language = patientEntity.getLanguage();
        this.diagnosis_date = patientEntity.getDiagnosis_date();
        this.onset_date = patientEntity.getOnset_date();
        this.last_worked_date = patientEntity.getLast_worked_date();
        this.case_call_status = patientEntity.getCase_call_status();
        this.travelled = patientEntity.getTravelled();
        this.saw_doctor = patientEntity.getSaw_doctor();
        this.knows_status = patientEntity.getKnows_status();
        this.insurance = patientEntity.getInsurance();
        this.times_called = patientEntity.getTimes_called();
        this.phone_number = patientEntity.getPhone_number();
        this.symptomatic = patientEntity.getSymptomatic();
        this.gender = patientEntity.getGender();
        this.race = patientEntity.getRace();
        this.self_isolate = patientEntity.getSelf_isolate();
        this.employment = patientEntity.getEmployment();
        this.home_location = patientEntity.getHome_location();
        this.housing_insecure = patientEntity.getHousing_insecure();
        this.shelter_name = patientEntity.getShelter_name();
        this.date_of_birth = patientEntity.getDate_of_birth();
        this.referral = patientEntity.getReferral();
        this.flagged = patientEntity.getFlagged();
        this.requested_interview = patientEntity.getRequested_interview();
        this.notes = patientEntity.getNotes();
        this.email = patientEntity.getEmail();
        this.manager_id = patientEntity.getManager_id();
        this.volunteer_id = patientEntity.getVolunteer_id();
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

    public Long getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(Long phone_number) {
        this.phone_number = phone_number;
    }

    public Symptomatic getSymptomatic() {
        return symptomatic;
    }

    public void setSymptomatic(Symptomatic symptomatic) {
        this.symptomatic = symptomatic;
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

    public Employment getEmployment() {
        return employment;
    }

    public void setEmployment(Employment employment) {
        this.employment = employment;
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
