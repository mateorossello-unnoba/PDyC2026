package ar.edu.unnoba.greaterevents.dtos.notification;

import ar.edu.unnoba.greaterevents.dtos.event.EventDetailResponse;
import ar.edu.unnoba.greaterevents.dtos.user.UserListResponse;
import ar.edu.unnoba.greaterevents.models.event.State;
import ar.edu.unnoba.greaterevents.models.notification.Notification;
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
    public static NotificationDetailResponse fromEntity(Notification notification) {
        return new NotificationDetailResponse(
            notification.getId(),
            EventDetailResponse.fromEntity(notification.getEvent()),
            UserListResponse.fromEntity(notification.getUser()),
            notification.getPreviousState(),
            notification.getCurrentState(),
            notification.getCreatedAt(),
            notification.isRead()
        );
    }
}
