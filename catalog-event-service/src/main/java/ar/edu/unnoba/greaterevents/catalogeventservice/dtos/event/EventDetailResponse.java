package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event;

import ar.edu.unnoba.greaterevents.catalogeventservice.dtos.artist.ArtistResponse;
import ar.edu.unnoba.greaterevents.catalogeventservice.models.event.Event;
import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDate;
import java.util.List;

/**
 * DTO de respuesta detallada para un evento.
 */

public record EventDetailResponse(
    Long id,
    String name,
    String description,
    String state,
    @JsonProperty("start_date") LocalDate startDate,
    List<ArtistResponse> artists
) {
    public static EventDetailResponse fromEntity(Event event) {
        List<ArtistResponse> artistResponses = event.getArtists().stream().map(ArtistResponse::fromEntity).toList();
        return new EventDetailResponse(
            event.getId(),
            event.getName(),
            event.getDescription(),
            event.getState().name(),
            event.getStartDate(),
            artistResponses
        );
    }
}
