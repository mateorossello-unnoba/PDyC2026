package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.artist;

/**
 * DTO de solicitud para la creación de un artista.
 */

public record ArtistCreateRequest(
    String name,
    String genre
) {}
