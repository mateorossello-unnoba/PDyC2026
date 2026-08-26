package ar.edu.unnoba.greaterevents.notificationservice.dtos.notification;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;

/**
 * DTO de solicitud para actualizar una notificación.
 */

public record NotificationUpdateRequest (
    @NotNull @JsonProperty("is_read") Boolean read
) {}
