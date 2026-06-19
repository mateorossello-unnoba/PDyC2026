package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.message;

public record EventStatusChange(
    Long eventId,
    String previousState,
    String currentState
) {}
