package ar.edu.unnoba.greaterevents.notificationservice.dtos.notification;

import ar.edu.unnoba.greaterevents.notificationservice.dtos.event.EventDetailResponse;
import ar.edu.unnoba.greaterevents.notificationservice.dtos.user.UserListResponse;
import ar.edu.unnoba.greaterevents.notificationservice.models.event.State;
import ar.edu.unnoba.greaterevents.notificationservice.models.notification.Notification;
import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDateTime;

public record NotificationDetailResponse (
    Long id,
    EventDetailResponse event,
    UserListResponse user,
    State previousState,
    State currentState,
    LocalDateTime createdAt,
    @JsonProperty("is_read")
    Boolean read
) {
    public static NotificationDetailResponse fromEntity(Notification notification, EventDetailResponse event, UserListResponse user) {
        return new NotificationDetailResponse(
            notification.getId(),
            event,
            user,
            notification.getPreviousState(),
            notification.getCurrentState(),
            notification.getCreatedAt(),
            notification.isRead()
        );
    }
}
