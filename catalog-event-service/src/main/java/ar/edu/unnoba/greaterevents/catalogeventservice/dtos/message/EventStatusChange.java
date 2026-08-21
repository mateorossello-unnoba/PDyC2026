package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.message;

/**
 * DTO que representa un mensaje de cambio de estado de un evento.
 */

public record EventStatusChange(
    Long eventId,
    String previousState,
    String currentState
) {}
