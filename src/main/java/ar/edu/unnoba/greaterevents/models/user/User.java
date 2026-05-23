package ar.edu.unnoba.greaterevents.models.user;

import ar.edu.unnoba.greaterevents.models.artist.Artist;
import ar.edu.unnoba.greaterevents.models.event.Event;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false, unique = true)
    private String email;

    @ManyToMany
    @JoinTable(name = "user_artists", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "artist_id"))
    private List<Artist> followedArtists = new ArrayList<>();

    @ManyToMany
    @JoinTable(name = "user_events", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "event_id"))
    private List<Event> favoriteEvents = new ArrayList<>();
}
