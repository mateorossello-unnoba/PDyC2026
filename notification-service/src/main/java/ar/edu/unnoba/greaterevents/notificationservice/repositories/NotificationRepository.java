package ar.edu.unnoba.greaterevents.notificationservice.repositories;

import ar.edu.unnoba.greaterevents.notificationservice.models.notification.*;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NotificationRepository extends JpaRepository<Notification, Long> {
    List<Notification> findByUsernameOrderByCreatedAtDesc(String username);
}
