package ar.edu.unnoba.greaterevents.dtos.artist;

import ar.edu.unnoba.greaterevents.models.artist.Artist;

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
