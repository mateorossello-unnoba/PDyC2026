package ar.edu.unnoba.greaterevents.catalogeventservice.controllers.event;

import ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.models.event.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.services.event.*;
import jakarta.validation.Valid;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Controlador para la gestión de eventos.
 */

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin/events")
public class EventController {
    private final EventService eventService;

    // Endpoint de creación.
    @PostMapping
    public ResponseEntity<EventDetailResponse> createEvent(@Valid @RequestBody EventCreateRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(eventService.createEvent(request));
    }

    // Endpoints de actualización.
    @PutMapping("/{id}")
    public ResponseEntity<EventDetailResponse> updateEvent(@PathVariable Long id, @Valid @RequestBody EventCreateRequest request) {
        return ResponseEntity.ok(eventService.updateEvent(id, request));
    }

    @PutMapping("/{eventId}/canceled")
    public ResponseEntity<EventDetailResponse> cancelEvent(@PathVariable Long eventId) {
        return ResponseEntity.ok(eventService.cancelEvent(eventId));
    }

    @PutMapping("/{eventId}/confirmed")
    public ResponseEntity<EventDetailResponse> confirmEvent(@PathVariable Long eventId) {
        return ResponseEntity.ok(eventService.confirmEvent(eventId));
    }

    @PutMapping("/{eventId}/rescheduled")
    public ResponseEntity<EventDetailResponse> rescheduleEvent(@PathVariable Long eventId, @Valid @RequestBody EventRescheduleRequest request) {
        return ResponseEntity.ok(eventService.rescheduleEvent(eventId, request));
    }

    @PostMapping("/{eventId}/artists")
    public ResponseEntity<Void> addArtistToEvent(@PathVariable Long eventId, @Valid @RequestBody EventAddArtistRequest request) {
        eventService.addArtistToEvent(eventId, request);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{eventId}/artist/{artistId}")
    public ResponseEntity<Void> removeArtistFromEvent(@PathVariable Long eventId, @PathVariable Long artistId) {
        eventService.removeArtistFromEvent(eventId, artistId);
        return ResponseEntity.noContent().build();
    }

    // Endpoint de eliminación.
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEvent(@PathVariable Long id) {
        eventService.deleteEvent(id);
        return ResponseEntity.noContent().build();
    }

    // Endpoints de consulta.
    @GetMapping("/{id}")
    public ResponseEntity<EventDetailResponse> getEventById(@PathVariable Long id) {
        return ResponseEntity.ok(eventService.getEventById(id));
    }

    @GetMapping
    public ResponseEntity<List<EventListResponse>> getEvents(@RequestParam(required = false) String state) {
        if (state != null) {
            return ResponseEntity.ok(eventService.getEvents(State.valueOf(state.toUpperCase())));
        } else {
            return ResponseEntity.ok(eventService.getEvents(null));
        }
    }
}
