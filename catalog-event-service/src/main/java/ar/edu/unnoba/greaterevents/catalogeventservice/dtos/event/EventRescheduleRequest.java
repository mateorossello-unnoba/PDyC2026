package ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDate;

public record EventRescheduleRequest(
    @JsonProperty("start_date") LocalDate startDate
) {}
