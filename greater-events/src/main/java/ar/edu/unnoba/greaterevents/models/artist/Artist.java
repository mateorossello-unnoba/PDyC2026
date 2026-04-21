package ar.edu.unnoba.greaterevents.models.artist;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

import ar.edu.unnoba.greaterevents.models.event.Event;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "artists")
@Getter 
@Setter 
@NoArgsConstructor
public class Artist {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Genre genre;

    @Column(nullable = false)
    private boolean active = true;

    @ManyToMany(mappedBy = "artists")
    private List<Event> events = new ArrayList<>();
}
