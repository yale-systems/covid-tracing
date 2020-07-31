package org.yale.registry.research.DTOs;

import com.bedatadriven.jackson.datatype.jts.serialization.GeometryDeserializer;
import com.bedatadriven.jackson.datatype.jts.serialization.GeometrySerializer;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.locationtech.jts.geom.Point;
import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.entities.PatientEntity;
import org.yale.registry.research.enums.EnumTypes.ReasonFlagged;
import org.yale.registry.research.enums.EnumTypes.Assistance;
import org.yale.registry.research.enums.EnumTypes.SuspectedExposure;
import org.yale.registry.research.enums.EnumTypes.PreexistingCondition;
import org.yale.registry.research.enums.EnumTypes.Symptom;
import org.yale.registry.research.enums.EnumTypes.Language;
import org.yale.registry.research.enums.EnumTypes.CaseCallStatus;
import org.yale.registry.research.enums.EnumTypes.SawDoctor;
import org.yale.registry.research.enums.EnumTypes.Insurance;
import org.yale.registry.research.enums.EnumTypes.Symptomatic;
import org.yale.registry.research.enums.EnumTypes.Gender;
import org.yale.registry.research.enums.EnumTypes.Race;
import org.yale.registry.research.enums.EnumTypes.SelfIsolate;
import org.yale.registry.research.enums.EnumTypes.Employment;
import org.yale.registry.research.utilities.EnumMapUtility;

import javax.persistence.*;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Getter
@Setter
@NoArgsConstructor
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

    private String phone_number;

    private Boolean symptomatic;

    private List<Symptom> symptoms;

    private Gender gender;

    private Race race;

    private SelfIsolate self_isolate;

    private List<PreexistingCondition> preexisting_conditions;

    private Employment employment;

    private List<SuspectedExposure> suspected_exposures;

    @JsonSerialize(using = GeometrySerializer.class)
    @JsonDeserialize(using = GeometryDeserializer.class)
    private Point home_location;

    private Boolean housing_insecure;

    private String shelter_name;

    private List<Assistance> assistances;

    @Temporal(TemporalType.TIMESTAMP)
    private Date date_of_birth;

    private Boolean referral;

    private Boolean flagged;

    private List<ReasonFlagged> reasons_flagged;

    private Boolean requested_interview;

    private String notes;

    private String email;

    private Long manager_id;

    private Long volunteer_id;

    private Map<String, Map<String, Integer>> enums;


    public PatientDTO(){}

    public PatientDTO(Long patient_id, String username, String password,
                      String first_name, String last_name, Language language,
                      Date diagnosis_date, Date onset_date, Date last_worked_date,
                      CaseCallStatus case_call_status, Boolean travelled, SawDoctor saw_doctor,
                      Boolean knows_status, Insurance insurance, Long times_called,
                      String phone_number, Boolean symptomatic, List<Symptom> symptoms,
                      Gender gender, Race race, SelfIsolate self_isolate,
                      List<PreexistingCondition> preexisting_conditions, Employment employment,
                      List<SuspectedExposure> suspected_exposures, Point home_location, Boolean housing_insecure,
                      String shelter_name, List<Assistance> assistances, Date date_of_birth, Boolean referral,
                      Boolean flagged, List<ReasonFlagged> reasons_flagged, Boolean requested_interview,
                      String notes, String email, Long manager_id, Long volunteer_id) {
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
        this.enums = EnumMapUtility.generateEnumMap(Arrays.asList(Language.class, CaseCallStatus.class, SawDoctor.class,
                Insurance.class, Symptomatic.class, Symptom.class, Gender.class, Race.class, SelfIsolate.class,
                PreexistingCondition.class, Employment.class, SuspectedExposure.class, Assistance.class,
                ReasonFlagged.class));
    }

    public PatientDTO(String username, String password, String first_name, String last_name,
                      Language language, Date diagnosis_date, Date onset_date, Date last_worked_date,
                      CaseCallStatus case_call_status, Boolean travelled, SawDoctor saw_doctor,
                      Boolean knows_status, Insurance insurance, Long times_called, String phone_number,
                      Boolean symptomatic, List<Symptom> symptoms, Gender gender, Race race,
                      SelfIsolate self_isolate, List<PreexistingCondition> preexisting_conditions,
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
        this.enums = EnumMapUtility.generateEnumMap(Arrays.asList(Language.class, CaseCallStatus.class, SawDoctor.class,
                Insurance.class, Symptomatic.class, Symptom.class, Gender.class, Race.class, SelfIsolate.class,
                PreexistingCondition.class, Employment.class, SuspectedExposure.class, Assistance.class,
                ReasonFlagged.class));
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
        this.symptoms = patientEntity.getSymptoms();
        this.gender = patientEntity.getGender();
        this.race = patientEntity.getRace();
        this.self_isolate = patientEntity.getSelf_isolate();
        this.preexisting_conditions = patientEntity.getPreexisting_conditions();
        this.employment = patientEntity.getEmployment();
        this.suspected_exposures = patientEntity.getSuspected_exposures();
        this.home_location = patientEntity.getHome_location();
        this.housing_insecure = patientEntity.getHousing_insecure();
        this.shelter_name = patientEntity.getShelter_name();
        this.assistances = patientEntity.getAssistances();
        this.date_of_birth = patientEntity.getDate_of_birth();
        this.referral = patientEntity.getReferral();
        this.flagged = patientEntity.getFlagged();
        this.reasons_flagged = patientEntity.getReasons_flagged();
        this.requested_interview = patientEntity.getRequested_interview();
        this.notes = patientEntity.getNotes();
        this.email = patientEntity.getEmail();
        this.manager_id = patientEntity.getManager_id();
        this.volunteer_id = patientEntity.getVolunteer_id();
        this.enums = EnumMapUtility.generateEnumMap(Arrays.asList(Language.class, CaseCallStatus.class, SawDoctor.class,
                Insurance.class, Symptomatic.class, Symptom.class, Gender.class, Race.class, SelfIsolate.class,
                PreexistingCondition.class, Employment.class, SuspectedExposure.class, Assistance.class,
                ReasonFlagged.class));
    }
}
