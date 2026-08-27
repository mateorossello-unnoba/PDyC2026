package ar.edu.unnoba.greaterevents.notificationservice.clients;

import ar.edu.unnoba.greaterevents.notificationservice.dtos.artist.*;
import ar.edu.unnoba.greaterevents.notificationservice.dtos.event.*;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * Permite interactuar con catalog-event-service y obtener información sobre artistas y eventos.
 */

@FeignClient(name = "catalog-event-service", fallback = CatalogEventFallback.class)
public interface CatalogEventClient {
    // Método para obtener un artista por su ID.
    @GetMapping("/internal/artists/{id}")
    ArtistResponse getArtistById(@PathVariable("id") Long id);

    // Método para obtener un evento por su ID.
    @GetMapping("/internal/events/{id}")
    EventDetailResponse getEventById(@PathVariable("id") Long id);
}
