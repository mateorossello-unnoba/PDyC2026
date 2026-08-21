package ar.edu.unnoba.greaterevents.catalogeventservice.services.artist;

import ar.edu.unnoba.greaterevents.catalogeventservice.dtos.artist.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.models.artist.*;
import java.util.List;

/**
 * Interfaz del servicio de artistas.
 */

public interface ArtistService {
    // Método de creación.
    ArtistResponse createArtist(ArtistCreateRequest request);
        
    // Método de actualización.
    ArtistResponse updateArtist(Long id, ArtistCreateRequest request);

    // Método de eliminación.
    void deleteArtist(Long id);

    // Métodos de consulta.
    ArtistResponse getArtistById(Long id);
    List<EventListResponse> getPublicEventsFromArtist(Long artistId);
    List<ArtistResponse> getArtists(Genre genre);
    List<ArtistResponse> getPublicArtists();
}
