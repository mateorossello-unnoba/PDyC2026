package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;

/**
 * DTO de solicitud para la creación de un evento.
 */

public record EventCreateRequest(
    @NotBlank String name,
    @NotBlank String description,
    @NotNull @JsonProperty("start_date") LocalDate startDate
) {}
