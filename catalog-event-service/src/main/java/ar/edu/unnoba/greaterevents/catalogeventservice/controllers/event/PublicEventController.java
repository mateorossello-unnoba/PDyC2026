package ar.edu.unnoba.greaterevents.catalogeventservice.controllers.event;

import ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.services.event.*;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Controlador público para la gestión de eventos.
 */

@RestController
@RequiredArgsConstructor
@RequestMapping("/events")
public class PublicEventController {
    private final EventService eventService;

    // Métodos de consulta
    @GetMapping("{id}")
    public ResponseEntity<EventDetailResponse> getEventById(@PathVariable Long id) {
        return ResponseEntity.ok(eventService.getPublicEventById(id));
    }

    @GetMapping
    public ResponseEntity<List<EventListResponse>> getEvents() {
        return ResponseEntity.ok(eventService.getPublicEvents());
    }
}
