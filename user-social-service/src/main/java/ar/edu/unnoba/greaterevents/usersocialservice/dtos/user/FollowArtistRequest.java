package ar.edu.unnoba.greaterevents.usersocialservice.dtos.user;

import jakarta.validation.constraints.NotNull;

/**
 * DTO de solicitud para seguir a un artista.
 */

public record FollowArtistRequest(
    @NotNull Long artistId
) {}
