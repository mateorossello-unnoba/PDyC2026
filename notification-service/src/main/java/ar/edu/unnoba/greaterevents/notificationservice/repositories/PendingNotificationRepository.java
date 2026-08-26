package ar.edu.unnoba.greaterevents.notificationservice.repositories;

import ar.edu.unnoba.greaterevents.notificationservice.models.notification.PendingNotification;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Repositorio para la entidad PendingNotification.
 */

public interface PendingNotificationRepository extends JpaRepository<PendingNotification, Long> {
    List<PendingNotification> findAllByOrderByCreatedAtAsc();
}
