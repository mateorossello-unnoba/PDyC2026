package ar.edu.unnoba.greaterevents.services.notification;

import ar.edu.unnoba.greaterevents.dtos.notification.*;
import ar.edu.unnoba.greaterevents.exceptions.ResourceNotFoundException;
import ar.edu.unnoba.greaterevents.models.event.Event;
import ar.edu.unnoba.greaterevents.models.event.State;
import ar.edu.unnoba.greaterevents.models.notification.*;
import ar.edu.unnoba.greaterevents.models.user.User;
import ar.edu.unnoba.greaterevents.repositories.NotificationRepository;
import java.time.LocalDateTime;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService {
    private final NotificationRepository notificationRepository;

    // Método auxiliar
    public Notification getNotificationByIdOrThrow(Long id) {
        return notificationRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Notification not found"));
    }

    // Implementación de métodos de la interfaz
    // Método de creación
    public void createNotification(Event event, User user, State previousState, State currentState) {
        Notification notification = new Notification();
        notification.setEvent(event);
        notification.setUser(user);
        notification.setPreviousState(previousState);
        notification.setCurrentState(currentState);
        notification.setCreatedAt(LocalDateTime.now());
        notificationRepository.save(notification);
    }

    // Método de actualización
    public NotificationDetailResponse markAsRead(String username, Long id, NotificationUpdateRequest request) {
        Notification notification = getNotificationByIdOrThrow(id);

        if (notification.getUser().getUsername().equalsIgnoreCase(username)) {
            notification.setRead(request.read() != null ? request.read() : notification.isRead());
            notificationRepository.save(notification);
            return NotificationDetailResponse.fromEntity(notification);
        } else {
            throw new IllegalStateException("You can only update your own notifications");
        }
    }

    // Método de eliminación
    public void deleteNotification(String username, Long id) {
        Notification notification = getNotificationByIdOrThrow(id);

        if (notification.getUser().getUsername().equalsIgnoreCase(username)) {
            notificationRepository.delete(notification);
        } else {
            throw new IllegalStateException("You can only delete your own notifications");
        }
    }

    // Método de consulta
    public List<NotificationDetailResponse> getMyNotifications(String username) {
        return notificationRepository.findByUserUsernameOrderByCreatedAtDesc(username).stream().map(NotificationDetailResponse::fromEntity).toList();
    }
}
