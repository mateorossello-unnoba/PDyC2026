package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDate;

/**
 * DTO de solicitud para la creación de un evento.
 */

public record EventCreateRequest(
    String name,
    String description,
    @JsonProperty("start_date") LocalDate startDate
) {}
