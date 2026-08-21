package ar.edu.unnoba.greaterevents.catalogeventservice.controllers.artist;

import ar.edu.unnoba.greaterevents.catalogeventservice.dtos.artist.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.models.artist.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.services.artist.*;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Controlador para la gestión de artistas.
 */

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin/artists")
public class ArtistController {
    private final ArtistService artistService;

    // Endpoint de creación.
    @PostMapping
    public ResponseEntity<ArtistResponse> createArtist(@RequestBody ArtistCreateRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(artistService.createArtist(request));
    }

    // Endpoint de actualización.
    @PutMapping("/{id}")
    public ResponseEntity<ArtistResponse> updateArtist(@PathVariable Long id, @RequestBody ArtistCreateRequest request) {
        return ResponseEntity.ok(artistService.updateArtist(id, request));
    }

    // Endpoint de eliminación.
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteArtist(@PathVariable Long id) {
        artistService.deleteArtist(id);
        return ResponseEntity.noContent().build();
    }

    // Endpoints de consulta.
    @GetMapping("/{id}")
    public ResponseEntity<ArtistResponse> getArtistById(@PathVariable Long id) {
        return ResponseEntity.ok(artistService.getArtistById(id));
    }

    @GetMapping
    public ResponseEntity<List<ArtistResponse>> getArtists(@RequestParam(required = false) String genre) {
        if (genre != null) {
            return ResponseEntity.ok(artistService.getArtists(Genre.valueOf(genre.toUpperCase())));
        } else {
            return ResponseEntity.ok(artistService.getArtists(null));
        }
    }
}
