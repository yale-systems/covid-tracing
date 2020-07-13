package org.yale.registry.research.enums;

public class EnumTypes {
    public enum ContactType{
        MINIMAL,
        CLOSE
    }
    public enum AgeDemographic {
        MINOR,
        ADULT,
        ELDERLY
    }
    public enum ContactCallStatus {
        HAVE_NOT_NOTIFIED_YET,
        NO_LEFT_VOICEMAIL,
        NO_DID_NOT_LEAVE_VOICEMAIL,
        UNABLE_TO_REACH,
        UNABLE_TO_REACH_BAD_NUMBER,
        YES_NOTIFIED_CONTACT,
        YES_NOTIFIED_FAMILY,
        YES_NOTIFIED_PROXY
    }
    public enum Relationship{
        PARENT,
        GRANDPARENT,
        CHILD,
        FRIEND,
        WORK_COLLEAGUE,
        OTHER,
        DONT_WANT_TO_SAY
    }
    public enum Language {
        ENGLISH,
        SPANISH,
        CHINESE,
        ARABIC
    }
    public enum Symptomatic {
        TESTED_POSITIVE,
        SYMPTOMATIC_NOT_TESTED,
        NO_SYMPTOMS,
        DONT_KNOW
    }
    public enum Symptoms {
        MILD_FATIGUE,
        LOW_GRADE_FEVER,
        COUGH,
        CHILLS,
        RUNNY_NOSE,
        NASAL_CONGESTION,
        LOSS_OF_TASTE_AND_OR_SMELL,
        HEADACHE,
        MUSCLE_AND_JOINT_PAIN,
        TIGHT_FEELING_IN_CHEST,
        TROUBLE_BREATHING
    }
    public enum SelfIsolate {
        YES,
        YES_BUT_NEED_ASSISTANCE,
        NO
    }
    public enum Assistance {
        FOOD_SUPPORT,
        SHELTER,
        FINANCIAL_SUPPORT,
        FINDING_PRIMARY_CARE_PHYSICIAN,
        HEALTHCARE_SUPPORT,
        HEALTH_INSURANCE,
        HOME_CARE_SUPPORT,
        MEDICATIONS_MEDICAL_SUPPLIES,
        PERSONAL_CARE_HYGEINE_ITEMS,
        MENTAL_HEALTH_SUPPORT,
        CLOTHING,
        OTHER
    }
    public enum CaseCallStatus {
        HAVE_NOT_CALLED_YET,
        CALLED_DIDNT_LEAVE_VOICEMAIL,
        CALLED_LEFT_VOICEMAIL,
        CALL_AGAIN,
        DOES_NOT_WANT_INTERVIEW,
        FAMILY_COMPLETED_INTERVIEW,
        PARTIAL_COMPLETED_INTERVIEW,
        PATIENT_COMPLETED_INTERVIEW,
        UNABLE_TO_REACH,
        UNABLE_TO_REACH_BAD_NUMBER
    }
    public enum PreexistingConditions {
        CHRONIC_RESPIRATORY_ILLNESS,
        CARDIOVASCULAR_DISEASE,
        DIABETES,
        CANCER,
        IMMUNOCOMPROMISED,
        IMMUNOSUPPRESSED,
        NONE_INDICATED,
        OTHER
    }
    public enum Gender {
        FEMALE,
        MALE,
        OTHER,
        PREFER_NOT_TO_DISCLOSE
    }
    public enum Race {
        AMERICAN_INDIAN_OR_ALASKA_NATIVE,
        ASIAN,
        BLACK_OR_AFRICAN_AMERICAN,
        HISPANIC_OR_LATINO,
        NATIVE_HAWAIIAN_OR_OTHER_PACIFIC_ISLANDER,
        WHITE,
        PREFER_NOT_TO_ANSWER
    }
    public enum SuspectedExposure {
        TRAVEL,
        HEALTHCARE_WORK,
        WORK,
        CLOSE_CONTACT_WITH_CONFIRMED_COVID19,
        OTHER,
        DONT_KNOW_UNSURE
    }
    public enum Employment {
        EMPLOYED,
        STUDENT,
        VOLUNTEER,
        STAY_AT_HOME_PARENT,
        UNEMPLOYED,
        RETIRED,
        DISABILITY
    }
    public enum SawDoctor {
        YES,
        NO,
        DO_NOT_HAVE_ONE
    }
    public enum Insurance {
        PRIVATE_INSURANCE,
        MEDICAID_HUSKY,
        MEDICARE,
        YALE_HEALTH_PLAN,
        COMBINATION_OF_HEALTH_INSURANCES,
        SELF_PAY_CASH,
        UNINSURED,
        DONT_KNOW_REFUSE_TO_SHARE
    }
    public enum ReasonFlagged {
        MEDICAL_EMERGENCY,
        RISK_OF_SELF_HARM_OR_HARM_TO_OTHERS,
        DOMESTIC_VIOLENCE
    }
}
