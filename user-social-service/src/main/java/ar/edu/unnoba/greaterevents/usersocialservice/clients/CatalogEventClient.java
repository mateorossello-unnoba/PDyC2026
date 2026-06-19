package ar.edu.unnoba.greaterevents.usersocialservice.clients;

import ar.edu.unnoba.greaterevents.usersocialservice.dtos.artist.*;
import ar.edu.unnoba.greaterevents.usersocialservice.dtos.event.*;
import java.util.List;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

// Permite interactuar con catalog-event-service para obtener información sobre artistas y eventos
@FeignClient(name = "catalog-event-service")
public interface CatalogEventClient {
    // Método para obtener un artista por su ID
    @GetMapping("/internal/artists/{id}")
    ArtistResponse getArtistById(@PathVariable("id") Long id);

    // Método para obtener un evento por su ID
    @GetMapping("/internal/events/{id}")
    EventDetailResponse getEventById(@PathVariable("id") Long id);

    // Método para obtener un resumen de un evento por su ID
    @GetMapping("/internal/events/{id}/summary")
    EventListResponse getEventSummaryById(@PathVariable("id") Long id);

    // Método para obtener todos los eventos de un artista dado su ID
    @GetMapping("/internal/events/artist/{artistId}")
    List<EventListResponse> getEventsByArtistId(@PathVariable("artistId") Long artistId);
}
