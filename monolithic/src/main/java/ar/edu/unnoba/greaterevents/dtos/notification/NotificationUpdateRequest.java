package ar.edu.unnoba.greaterevents.dtos.notification;

import com.fasterxml.jackson.annotation.JsonProperty;

public record NotificationUpdateRequest (
    @JsonProperty("is_read")
    Boolean read
) {}
