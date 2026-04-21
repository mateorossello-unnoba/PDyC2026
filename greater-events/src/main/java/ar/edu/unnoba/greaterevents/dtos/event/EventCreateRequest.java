package ar.edu.unnoba.greaterevents.dtos.event;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDate;

public record EventCreateRequest(
    String name,
    String description,
    @JsonProperty("start_date") LocalDate startDate
) {}
