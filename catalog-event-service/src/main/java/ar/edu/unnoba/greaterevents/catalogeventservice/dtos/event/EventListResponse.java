package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event;

import ar.edu.unnoba.greaterevents.catalogeventservice.models.event.Event;
import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDate;

/**
 * DTO de respuesta resumida para un evento.
 */

public record EventListResponse(
    Long id,
    String name,
    String state,
    @JsonProperty("start_date") LocalDate startDate,
    @JsonProperty("assigned_artists_count") int assignedArtistsCount
) {
    public static EventListResponse fromEntity(Event event) {
        return new EventListResponse(
            event.getId(),
            event.getName(),
            event.getState().name(),
            event.getStartDate(),
            event.getArtists().size()
        );
    }
}
