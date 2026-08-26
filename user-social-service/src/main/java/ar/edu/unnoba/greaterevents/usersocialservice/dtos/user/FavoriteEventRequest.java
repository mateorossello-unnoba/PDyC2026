package ar.edu.unnoba.greaterevents.usersocialservice.dtos.user;

import jakarta.validation.constraints.NotNull;

/**
 * DTO de solicitud para agregar un evento como favorito.
 */

public record FavoriteEventRequest(
    @NotNull Long eventId
) {}
