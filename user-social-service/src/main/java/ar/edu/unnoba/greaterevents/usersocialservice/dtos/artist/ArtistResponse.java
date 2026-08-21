package ar.edu.unnoba.greaterevents.usersocialservice.dtos.artist;

/**
 * DTO de respuesta para un artista.
 */

public record ArtistResponse(
    Long id,
    String name,
    String genre
) {}
