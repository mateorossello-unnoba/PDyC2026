package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * DTO de solicitud para agregar un artista a un evento.
 */

public record EventAddArtistRequest(
    @JsonProperty("artist_id") Long artistId
) {}
