package ar.edu.unnoba.greaterevents.notificationservice.models.notification;

import ar.edu.unnoba.greaterevents.notificationservice.models.event.*;
import jakarta.persistence.*;
import java.time.LocalDateTime;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Entidad que representa una notificación pendiente en el sistema.
 */

@Entity
@Table(name = "pending_notifications")
@Getter
@Setter
@NoArgsConstructor
public class PendingNotification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "event_id", nullable = false)
    private Long eventId;

    @Enumerated(EnumType.STRING)
    @Column(name = "previous_state", nullable = false)
    private State previousState;

    @Enumerated(EnumType.STRING)
    @Column(name = "current_state", nullable = false)
    private State currentState;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;
}
