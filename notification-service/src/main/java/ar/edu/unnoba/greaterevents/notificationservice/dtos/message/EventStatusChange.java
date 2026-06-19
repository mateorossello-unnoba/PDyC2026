package ar.edu.unnoba.greaterevents.notificationservice.dtos.message;

public record EventStatusChange(
    Long eventId,
    String previousState,
    String currentState
) {}
