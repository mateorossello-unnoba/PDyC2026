package ar.edu.unnoba.greaterevents.usersocialservice.dtos.event;

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
) {}
