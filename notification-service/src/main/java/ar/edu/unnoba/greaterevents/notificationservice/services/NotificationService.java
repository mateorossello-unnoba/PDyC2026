package ar.edu.unnoba.greaterevents.notificationservice.services;

import ar.edu.unnoba.greaterevents.notificationservice.dtos.notification.*;
import ar.edu.unnoba.greaterevents.notificationservice.models.event.State;
import java.util.List;

public interface NotificationService {
    void processEventStatusChange(Long eventId, State previousState, State currentState);

    // Método de creación
    void createNotification(Long eventId, String username, State previousState, State currentState);

    // Método de actualización
    NotificationDetailResponse markAsRead(String username, Long id, NotificationUpdateRequest request);

    // Método de eliminación
    void deleteNotification(String username, Long id);

    // Método de consulta
    List<NotificationDetailResponse> getMyNotifications(String username);
}
