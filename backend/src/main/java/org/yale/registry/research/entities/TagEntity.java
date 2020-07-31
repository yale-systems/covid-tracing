package org.yale.registry.research.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "tags")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TagEntity {
    @Id
    @SequenceGenerator(name = "tags_generator", sequenceName = "tags_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "tags_generator")
    private Long tag_id;

    private String mac_address;

    private String info;

    private String worst_case_rssi;

    private String flags;

    private String first_contact;

    private String last_contact;

    private Integer minutes_of_appr_contact;


    public TagEntity(String mac_address, String info, String worst_case_rssi, String flags, Integer minutes_of_appr_contact) {
        this.mac_address = mac_address;
        this.info = info;
        this.worst_case_rssi = worst_case_rssi;
        this.flags = flags;
        this.minutes_of_appr_contact = minutes_of_appr_contact;
    }
}
