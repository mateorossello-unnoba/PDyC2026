package ar.edu.unnoba.greaterevents.usersocialservice.dtos.user;

/**
 * DTO de solicitud para seguir a un artista.
 */

public record FollowArtistRequest(
    Long artistId
) {}
