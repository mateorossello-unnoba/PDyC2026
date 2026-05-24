package ar.edu.unnoba.greaterevents.controllers.artist;

import ar.edu.unnoba.greaterevents.dtos.artist.*;
import ar.edu.unnoba.greaterevents.dtos.event.EventListResponse;
import ar.edu.unnoba.greaterevents.services.artist.*;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/artists")
public class PublicArtistController {
    private final ArtistService artistService;

    // Endpoints de consulta
    @GetMapping("/{id}/events")
    public ResponseEntity<List<EventListResponse>> getPublicEventsFromArtist(@PathVariable Long id) {
        return ResponseEntity.ok(artistService.getPublicEventsFromArtist(id));
    }

    @GetMapping
    public ResponseEntity<List<ArtistResponse>> getArtists() {
        return ResponseEntity.ok(artistService.getPublicArtists());
    }
}
