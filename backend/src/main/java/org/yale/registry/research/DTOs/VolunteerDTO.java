package org.yale.registry.research.DTOs;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.hateoas.RepresentationModel;
import org.yale.registry.research.entities.VolunteerEntity;
import org.yale.registry.research.enums.EnumTypes.Language;
import org.yale.registry.research.utilities.EnumMapUtility;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Getter
@Setter
@NoArgsConstructor
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

    private Map<String, Map<String, Integer>> enums;


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
        this.enums = EnumMapUtility.generateEnumMap(Arrays.asList(Language.class));
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
        this.enums = EnumMapUtility.generateEnumMap(Arrays.asList(Language.class));
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
        this.enums = EnumMapUtility.generateEnumMap(Arrays.asList(Language.class));
    }
}
