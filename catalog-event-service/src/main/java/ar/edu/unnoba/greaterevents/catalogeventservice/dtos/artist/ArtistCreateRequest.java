package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.artist;

import jakarta.validation.constraints.NotBlank;

/**
 * DTO de solicitud para la creación de un artista.
 */

public record ArtistCreateRequest(
    @NotBlank String name,
    @NotBlank String genre
) {}
