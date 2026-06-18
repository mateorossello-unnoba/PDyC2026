package ar.edu.unnoba.greaterevents.usersocialservice.models.user;

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
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "username", nullable = false, unique = true)
    private String username;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @ElementCollection
    @CollectionTable(name = "user_artists", joinColumns = @JoinColumn(name = "user_id"))
    @Column(name = "artist_id")
    private List<Long> followedArtists = new ArrayList<>();

    @ElementCollection
    @CollectionTable(name = "user_events", joinColumns = @JoinColumn(name = "user_id"))
    @Column(name = "event_id")
    private List<Long> favoriteEvents = new ArrayList<>();
}
