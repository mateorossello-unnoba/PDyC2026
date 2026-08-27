package ar.edu.unnoba.greaterevents.notificationservice.services;

import ar.edu.unnoba.greaterevents.notificationservice.clients.CatalogEventClient;
import ar.edu.unnoba.greaterevents.notificationservice.clients.UserSocialClient;
import ar.edu.unnoba.greaterevents.notificationservice.dtos.artist.*;
import ar.edu.unnoba.greaterevents.notificationservice.dtos.event.*;
import ar.edu.unnoba.greaterevents.notificationservice.dtos.notification.*;
import ar.edu.unnoba.greaterevents.notificationservice.dtos.user.*;
import ar.edu.unnoba.greaterevents.notificationservice.exceptions.ResourceNotFoundException;
import ar.edu.unnoba.greaterevents.notificationservice.models.event.*;
import ar.edu.unnoba.greaterevents.notificationservice.models.notification.*;
import ar.edu.unnoba.greaterevents.notificationservice.repositories.NotificationRepository;
import ar.edu.unnoba.greaterevents.notificationservice.repositories.PendingNotificationRepository;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import lombok.extern.slf4j.Slf4j;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

/**
 * Implementación del servicio de notificaciones.
 */

@Slf4j
@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService {
    private final NotificationRepository notificationRepository;
    private final PendingNotificationRepository pendingNotificationRepository;
    private final CatalogEventClient catalogEventClient;
    private final UserSocialClient userSocialClient;

    // Métodos auxiliares.
    public Notification getNotificationByIdOrThrow(Long id) {
        return notificationRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Notification not found."));
    }

    public void processEventStatusChange(Long eventId, State previousState, State currentState) {
        if (!createNotification(eventId, previousState, currentState)) {
            savePendingNotification(eventId, previousState, currentState);
        }
    }

    private boolean createNotification(Long eventId, State previousState, State currentState) {
        EventDetailResponse event = catalogEventClient.getEventById(eventId);

        if (event == null) {
            log.warn("Catalog Event Service is unavailable. Pending notification will be saved for event with ID {}: {} -> {}", eventId, previousState, currentState);
            return false;
        }

        Set<Long> artistIds = event.artists().stream().map(ArtistResponse::id).collect(Collectors.toSet());
        Set<UserListResponse> users = userSocialClient.getInterestedUsers(eventId, artistIds);
        
        if (users == null) {
            log.warn("User Social Service is unavailable. Pending notification will be saved for event with ID {}: {} -> {}", eventId, previousState, currentState);
            return false;
        }

        List<Notification> notifications = users.stream().map(user -> {
            Notification notification = new Notification();
            notification.setEventId(eventId);
            notification.setUsername(user.username());
            notification.setPreviousState(previousState);
            notification.setCurrentState(currentState);
            notification.setCreatedAt(LocalDateTime.now());
            return notification;
        }).toList();

        if (!notifications.isEmpty()) {
            notificationRepository.saveAll(notifications);
        }

        return true;
    }

    private void savePendingNotification(Long eventId, State previousState, State currentState) {
        PendingNotification pendingNotification = new PendingNotification();
        pendingNotification.setEventId(eventId);
        pendingNotification.setPreviousState(previousState);
        pendingNotification.setCurrentState(currentState);
        pendingNotification.setCreatedAt(LocalDateTime.now());
        pendingNotificationRepository.save(pendingNotification);

        log.info("Pending notification saved for event with ID {}: {} -> {}", eventId, previousState, currentState);
    }

    @Scheduled(fixedDelayString = "3600000")
    public void retryPendingNotifications() {
        pendingNotificationRepository.findAllByOrderByCreatedAtAsc().forEach(pendingNotification -> {
            if (createNotification(pendingNotification.getEventId(), pendingNotification.getPreviousState(), pendingNotification.getCurrentState())) {
                pendingNotificationRepository.delete(pendingNotification);
            }
        });
    }

    //
    // Implementación de métodos de la interfaz.
    //
    
    // Método de creación.
    public void createNotification(Long eventId, String username, State previousState, State currentState) {
        Notification notification = new Notification();
        notification.setEventId(eventId);
        notification.setUsername(username);
        notification.setPreviousState(previousState);
        notification.setCurrentState(currentState);
        notification.setCreatedAt(LocalDateTime.now());
        notificationRepository.save(notification);
    }

    // Método de actualización.
    public NotificationDetailResponse markAsRead(String username, Long id, NotificationUpdateRequest request) {
        Notification notification = getNotificationByIdOrThrow(id);

        if (notification.getUsername().equalsIgnoreCase(username)) {
            notification.setRead(request.read() != null ? request.read() : notification.isRead());
            notificationRepository.save(notification);

            EventDetailResponse event = catalogEventClient.getEventById(notification.getEventId());
            UserListResponse user = userSocialClient.getUserByUsername(notification.getUsername());

            return NotificationDetailResponse.fromEntity(notification, event, user);
        } else {
            throw new IllegalStateException("You can only update your own notifications.");
        }
    }

    // Método de eliminación.
    public void deleteNotification(String username, Long id) {
        Notification notification = getNotificationByIdOrThrow(id);

        if (notification.getUsername().equalsIgnoreCase(username)) {
            notificationRepository.delete(notification);
        } else {
            throw new IllegalStateException("You can only delete your own notifications.");
        }
    }

    // Método de consulta.
    public List<NotificationDetailResponse> getMyNotifications(String username) {
        UserListResponse user = userSocialClient.getUserByUsername(username);

        return notificationRepository.findByUsernameOrderByCreatedAtDesc(username).stream().map(notification -> {
            EventDetailResponse event = catalogEventClient.getEventById(notification.getEventId());
            return NotificationDetailResponse.fromEntity(notification, event, user);
        }).toList();
    }
}
