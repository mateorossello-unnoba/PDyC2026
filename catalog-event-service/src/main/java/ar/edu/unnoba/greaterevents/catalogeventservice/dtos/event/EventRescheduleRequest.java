package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;

/**
 * DTO de solicitud para reprogramar un evento.
 */

public record EventRescheduleRequest(
    @NotNull @JsonProperty("start_date") LocalDate startDate
) {}
