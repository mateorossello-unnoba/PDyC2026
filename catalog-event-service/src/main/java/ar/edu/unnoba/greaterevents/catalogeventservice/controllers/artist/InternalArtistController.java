package ar.edu.unnoba.greaterevents.catalogeventservice.controllers.artist;

import ar.edu.unnoba.greaterevents.catalogeventservice.dtos.artist.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.services.artist.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Controlador interno para la gestión de artistas.
 */

@RestController
@RequiredArgsConstructor
@RequestMapping("/internal/artists")
public class InternalArtistController {
    private final ArtistService artistService;

    // Endpoint de consulta.
    @GetMapping("/{id}")
    public ResponseEntity<ArtistResponse> getArtistById(@PathVariable Long id) {
        return ResponseEntity.ok(artistService.getArtistById(id));
    }
}
