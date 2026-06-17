package ar.edu.unnoba.greaterevents.repositories;

import ar.edu.unnoba.greaterevents.models.notification.Notification;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NotificationRepository extends JpaRepository<Notification, Long> {
    List<Notification> findByUserUsernameOrderByCreatedAtDesc(String username);
}
