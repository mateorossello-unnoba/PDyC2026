package ar.edu.unnoba.greaterevents.models.notification;

import ar.edu.unnoba.greaterevents.models.event.Event;
import ar.edu.unnoba.greaterevents.models.event.State;
import ar.edu.unnoba.greaterevents.models.user.User;
import jakarta.persistence.*;
import java.time.LocalDateTime;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "notifications")
@Getter 
@Setter 
@NoArgsConstructor
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "event_id", nullable = false)
    private Event event;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Enumerated(EnumType.STRING)
    @Column(name = "previous_state", nullable = false)
    private State previousState;

    @Enumerated(EnumType.STRING)
    @Column(name = "current_state", nullable = false)
    private State currentState;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "is_read", nullable = false)
    private boolean read = false;
}
