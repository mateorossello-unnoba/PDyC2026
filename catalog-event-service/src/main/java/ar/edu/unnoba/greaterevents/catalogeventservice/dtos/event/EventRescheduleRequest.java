package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDate;

/**
 * DTO de solicitud para reprogramar un evento.
 */

public record EventRescheduleRequest(
    @JsonProperty("start_date") LocalDate startDate
) {}
