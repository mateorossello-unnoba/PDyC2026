package ar.edu.unnoba.greaterevents.services.notification;

import ar.edu.unnoba.greaterevents.dtos.notification.*;
import ar.edu.unnoba.greaterevents.models.event.Event;
import ar.edu.unnoba.greaterevents.models.event.State;
import ar.edu.unnoba.greaterevents.models.user.User;
import java.util.List;

public interface NotificationService {
    // Método de creación
    void createNotification(Event event, User user, State previousState, State currentState);

    // Método de actualización
    NotificationDetailResponse markAsRead(String username, Long id, NotificationUpdateRequest request);

    // Método de eliminación
    void deleteNotification(String username, Long id);

    // Método de consulta
    List<NotificationDetailResponse> getMyNotifications(String username);
}
