package ar.edu.unnoba.greaterevents.usersocialservice.dtos.user;

/**
 * DTO de solicitud para agregar un evento como favorito.
 */

public record FavoriteEventRequest(
    Long eventId
) {}
