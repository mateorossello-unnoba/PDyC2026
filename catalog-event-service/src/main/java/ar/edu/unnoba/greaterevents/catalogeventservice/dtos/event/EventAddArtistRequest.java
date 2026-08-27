package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;

/**
 * DTO de solicitud para agregar un artista a un evento.
 */

public record EventAddArtistRequest(
    @NotNull @JsonProperty("artist_id") Long artistId
) {}
