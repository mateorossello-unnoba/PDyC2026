package ar.edu.unnoba.greaterevents.usersocialservice.dtos.event;

import ar.edu.unnoba.greaterevents.usersocialservice.dtos.artist.ArtistResponse;
import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDate;
import java.util.List;

public record EventDetailResponse(
    Long id,
    String name,
    String description,
    String state,
    @JsonProperty("start_date") LocalDate startDate,
    List<ArtistResponse> artists
) {}
