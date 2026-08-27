package ar.edu.unnoba.greaterevents.catalogeventservice.controllers.event;

import ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.services.event.*;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Controlador interno para la gestión de eventos.
 */

@RestController
@RequiredArgsConstructor
@RequestMapping("/internal/events")
public class InternalEventController {
    private final EventService eventService;

    // Endpoints de consulta.
    @GetMapping("/{id}")
    public ResponseEntity<EventDetailResponse> getEventById(@PathVariable Long id) {
        return ResponseEntity.ok(eventService.getEventById(id));
    }

    @GetMapping("/{id}/summary")
    public ResponseEntity<EventListResponse> getEventSummaryById(@PathVariable Long id) {
        return ResponseEntity.ok(eventService.getPublicEventSummaryById(id));
    }

    @GetMapping("/artist/{artistId}")
    public ResponseEntity<List<EventListResponse>> getEventsByArtistId(@PathVariable Long artistId) {
        return ResponseEntity.ok(eventService.getPublicEventsByArtistId(artistId));
    }
}
