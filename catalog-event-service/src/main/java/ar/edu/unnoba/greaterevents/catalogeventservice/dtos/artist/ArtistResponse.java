package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.artist;

import ar.edu.unnoba.greaterevents.catalogeventservice.models.artist.Artist;

/**
 * DTO de respuesta para un artista.
 */

public record ArtistResponse(
    Long id,
    String name,
    String genre
) {
    public static ArtistResponse fromEntity(Artist artist) {
        return new ArtistResponse(
            artist.getId(),
            artist.getName(),
            artist.getGenre().name()
        );
    }
}
