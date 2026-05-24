package ar.edu.unnoba.greaterevents.services.artist;

import ar.edu.unnoba.greaterevents.dtos.artist.*;
import ar.edu.unnoba.greaterevents.dtos.event.EventListResponse;
import ar.edu.unnoba.greaterevents.models.artist.*;
import java.util.List;

public interface ArtistService {
    // Método de creación
    ArtistResponse createArtist(ArtistCreateRequest request);
        
    // Método de actualización
    ArtistResponse updateArtist(Long id, ArtistCreateRequest request);

    // Método de eliminación
    void deleteArtist(Long id);

    // Métodos de consulta
    ArtistResponse getArtistById(Long id);
    List<EventListResponse> getPublicEventsFromArtist(Long artistId);
    List<ArtistResponse> getArtists(Genre genre);
    List<ArtistResponse> getPublicArtists();
}
