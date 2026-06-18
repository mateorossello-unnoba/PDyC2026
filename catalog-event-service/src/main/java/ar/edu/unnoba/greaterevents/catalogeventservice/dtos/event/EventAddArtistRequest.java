package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event;

import com.fasterxml.jackson.annotation.JsonProperty;

public record EventAddArtistRequest(
    @JsonProperty("artist_id") Long artistId
) {}
