package ar.edu.unnoba.greaterevents.catalogeventservice.models.artist;

import ar.edu.unnoba.greaterevents.catalogeventservice.models.event.Event;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Entidad que representa a un artista en el sistema.
 */

@Entity
@Table(name = "artists")
@Getter 
@Setter 
@NoArgsConstructor
public class Artist {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @Enumerated(EnumType.STRING)
    @Column(name = "genre", nullable = false)
    private Genre genre;

    @Column(name = "active", nullable = false)
    private boolean active = true;

    @ManyToMany(mappedBy = "artists")
    private List<Event> events = new ArrayList<>();
}
