package ar.edu.unnoba.greaterevents.controllers.event;

import ar.edu.unnoba.greaterevents.dtos.event.*;
import ar.edu.unnoba.greaterevents.services.event.*;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
