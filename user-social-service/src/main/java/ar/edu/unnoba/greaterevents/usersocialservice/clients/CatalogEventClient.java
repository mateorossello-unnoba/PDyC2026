package ar.edu.unnoba.greaterevents.usersocialservice.clients;

import ar.edu.unnoba.greaterevents.usersocialservice.dtos.artist.*;
import ar.edu.unnoba.greaterevents.usersocialservice.dtos.event.*;
import java.util.List;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "catalog-event-service")
public interface CatalogEventClient {
    @GetMapping("/artists/{id}")
    ArtistResponse getArtistById(@PathVariable("id") Long id);

    @GetMapping("/events/{id}")
    EventDetailResponse getEventById(@PathVariable("id") Long id);

    @GetMapping("/events/{id}/summary")
    EventListResponse getEventSummaryById(@PathVariable("id") Long id);

    @GetMapping("/events/artist/{artistId}")
    List<EventListResponse> getEventsByArtistId(@PathVariable("artistId") Long artistId);
}
