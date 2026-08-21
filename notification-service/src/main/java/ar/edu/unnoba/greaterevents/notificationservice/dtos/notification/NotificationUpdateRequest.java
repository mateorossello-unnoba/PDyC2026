package ar.edu.unnoba.greaterevents.notificationservice.dtos.notification;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * DTO de solicitud para actualizar una notificación.
 */

public record NotificationUpdateRequest (
    @JsonProperty("is_read") Boolean read
) {}
