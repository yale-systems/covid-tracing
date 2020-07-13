package org.yale.registry.research.DTOs;

import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.entities.VolunteerEntity;
import org.yale.registry.research.enums.EnumTypes.Language;

import java.util.List;

public class VolunteerDTO extends RepresentationModel<VolunteerDTO> {
    private Long volunteer_id;

    private String username;

    private String password;

    private String first_name;

    private String last_name;

    private List<Language> languages;

    private Boolean interviewer;

    private Long total_capacity;

    private Long remaining_capacity;

    private Long current_cases;

    private Long completed_cases;

    private String email;

    private Long manager_id;


    public VolunteerDTO(){}

    public VolunteerDTO(Long volunteer_id, String username, String password,
                           String first_name, String last_name, List<Language> languages, Boolean interviewer,
                           Long total_capacity, Long remaining_capacity, Long current_cases,
                           Long completed_cases, String email, Long manager_id) {
        this.volunteer_id = volunteer_id;
        this.username = username;
        this.password = password;
        this.first_name = first_name;
        this.last_name = last_name;
        this.languages = languages;
        this.interviewer = interviewer;
        this.total_capacity = total_capacity;
        this.remaining_capacity = remaining_capacity;
        this.current_cases = current_cases;
        this.completed_cases = completed_cases;
        this.email = email;
        this.manager_id = manager_id;
    }

    public VolunteerDTO(String username, String password,
                           String first_name, String last_name, List<Language> languages, Boolean interviewer,
                           Long total_capacity, Long remaining_capacity, Long current_cases,
                           Long completed_cases, String email, Long manager_id) {
        this.username = username;
        this.password = password;
        this.first_name = first_name;
        this.last_name = last_name;
        this.languages = languages;
        this.interviewer = interviewer;
        this.total_capacity = total_capacity;
        this.remaining_capacity = remaining_capacity;
        this.current_cases = current_cases;
        this.completed_cases = completed_cases;
        this.email = email;
        this.manager_id = manager_id;
    }

    public VolunteerDTO(VolunteerEntity volunteerEntity) {
        this.volunteer_id = volunteerEntity.getVolunteer_id();
        this.username = volunteerEntity.getUsername();
        this.password = volunteerEntity.getPassword();
        this.first_name = volunteerEntity.getFirst_name();
        this.last_name = volunteerEntity.getLast_name();
        this.languages = volunteerEntity.getLanguages();
        this.interviewer = volunteerEntity.getInterviewer();
        this.total_capacity = volunteerEntity.getTotal_capacity();
        this.remaining_capacity = volunteerEntity.getRemaining_capacity();
        this.current_cases = volunteerEntity.getCurrent_cases();
        this.completed_cases = volunteerEntity.getCompleted_cases();
        this.email = volunteerEntity.getEmail();
        this.manager_id = volunteerEntity.getManager_id();
    }

    public Long getVolunteer_id() {
        return volunteer_id;
    }

    public void setVolunteer_id(Long volunteer_id) {
        this.volunteer_id = volunteer_id;
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

    public List<Language> getLanguages() {
        return languages;
    }

    public void setLanguages(List<Language> languages) {
        this.languages = languages;
    }

    public Boolean getInterviewer() {
        return interviewer;
    }

    public void setInterviewer(Boolean interviewer) {
        this.interviewer = interviewer;
    }

    public Long getTotal_capacity() {
        return total_capacity;
    }

    public void setTotal_capacity(Long total_capacity) {
        this.total_capacity = total_capacity;
    }

    public Long getRemaining_capacity() {
        return remaining_capacity;
    }

    public void setRemaining_capacity(Long remaining_capacity) {
        this.remaining_capacity = remaining_capacity;
    }

    public Long getCurrent_cases() {
        return current_cases;
    }

    public void setCurrent_cases(Long current_cases) {
        this.current_cases = current_cases;
    }

    public Long getCompleted_cases() {
        return completed_cases;
    }

    public void setCompleted_cases(Long completed_cases) {
        this.completed_cases = completed_cases;
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
}
