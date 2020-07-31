package org.yale.registry.research.entities;

import com.vladmihalcea.hibernate.type.array.ListArrayType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.Parameter;
import org.yale.registry.research.DTOs.VolunteerDTO;
import org.yale.registry.research.enums.EnumTypes.Language;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "volunteers")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class VolunteerEntity {
    @Id
    @SequenceGenerator(
            name = "volunteers_generator",
            sequenceName = "volunteers_id_seq",
            allocationSize = 1
    )
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "volunteers_generator")
    private Long volunteer_id;

    private String username;

    private String password;

    private String first_name;

    private String last_name;

    @Type(
            type = "com.vladmihalcea.hibernate.type.array.ListArrayType",
            parameters = {
                    @Parameter(
                            name = ListArrayType.SQL_ARRAY_TYPE,
                            value = "language_t"
                    )
            }
    )
    @Column(columnDefinition = "language_t[]")
    private List<Language> languages;

    private Boolean interviewer;

    private Long total_capacity;

    private Long remaining_capacity;

    private Long current_cases;

    private Long completed_cases;

    private String email;

    private Long manager_id;


    public VolunteerEntity(String username, String password,
                           String first_name, String last_name, List<Language> languages,
                           Boolean interviewer, Long total_capacity, Long remaining_capacity,
                           Long current_cases, Long completed_cases, String email, Long manager_id) {
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

    public VolunteerEntity(VolunteerDTO volunteerDTO) {
        this.volunteer_id = volunteerDTO.getVolunteer_id();
        this.username = volunteerDTO.getUsername();
        this.password = volunteerDTO.getPassword();
        this.first_name = volunteerDTO.getFirst_name();
        this.last_name = volunteerDTO.getLast_name();
        this.interviewer = volunteerDTO.getInterviewer();
        this.total_capacity = volunteerDTO.getTotal_capacity();
        this.remaining_capacity = volunteerDTO.getRemaining_capacity();
        this.current_cases = volunteerDTO.getCurrent_cases();
        this.completed_cases = volunteerDTO.getCompleted_cases();
        this.email = volunteerDTO.getEmail();
        this.manager_id = volunteerDTO.getManager_id();
    }

    public void update(VolunteerDTO volunteerDTO){
        this.volunteer_id = volunteerDTO.getVolunteer_id();
        this.username = volunteerDTO.getUsername();
        this.password = volunteerDTO.getPassword();
        this.first_name = volunteerDTO.getFirst_name();
        this.last_name = volunteerDTO.getLast_name();
        this.languages = volunteerDTO.getLanguages();
        this.interviewer = volunteerDTO.getInterviewer();
        this.total_capacity = volunteerDTO.getTotal_capacity();
        this.remaining_capacity = volunteerDTO.getRemaining_capacity();
        this.current_cases = volunteerDTO.getCurrent_cases();
        this.completed_cases = volunteerDTO.getCompleted_cases();
        this.email = volunteerDTO.getEmail();
        this.manager_id = volunteerDTO.getManager_id();
    }
}
