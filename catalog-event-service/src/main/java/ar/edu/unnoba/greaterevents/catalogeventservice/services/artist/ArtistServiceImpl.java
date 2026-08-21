package ar.edu.unnoba.greaterevents.catalogeventservice.services.artist;

import ar.edu.unnoba.greaterevents.catalogeventservice.dtos.artist.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.exceptions.ResourceNotFoundException;
import ar.edu.unnoba.greaterevents.catalogeventservice.models.artist.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.models.event.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.repositories.ArtistRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * Implementación del servicio de artistas.
 */

@Service
@RequiredArgsConstructor
public class ArtistServiceImpl implements ArtistService {
    private final ArtistRepository artistRepository;

    // Métodos auxiliares.
    public Artist getArtistByIdOrThrow(Long id) {
        return artistRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Artist not found."));
    }

    //
    // Implementación de métodos de la interfaz.
    //

    // Método de creación.
    public ArtistResponse createArtist(ArtistCreateRequest request) {
        Artist artist = new Artist();

        artist.setName(request.name());
        artist.setGenre(Genre.valueOf(request.genre().toUpperCase()));

        artistRepository.save(artist);
        return ArtistResponse.fromEntity(artist);
    }

    // Método de actualización.
    public ArtistResponse updateArtist(Long id, ArtistCreateRequest request) {
        Artist artist = getArtistByIdOrThrow(id);

        if (!artist.getEvents().isEmpty()) {
            throw new IllegalStateException("Cannot update artist associated with events.");
        }
        
        artist.setName(request.name());
        artist.setGenre(Genre.valueOf(request.genre().toUpperCase()));
            
        artistRepository.save(artist);
        return ArtistResponse.fromEntity(artist);
    }

    // Método de eliminación.
    public void deleteArtist(Long id) {
        Artist artist = getArtistByIdOrThrow(id);

        if (!artist.getEvents().isEmpty()) {
            artist.setActive(false);
            artistRepository.save(artist);
        } else {
            artistRepository.delete(artist);
        }
    }

    // Métodos de consulta.
    public ArtistResponse getArtistById(Long id) {
        return ArtistResponse.fromEntity(getArtistByIdOrThrow(id));
    }

    public List<EventListResponse> getPublicEventsFromArtist(Long artistId) {
        Artist artist = getArtistByIdOrThrow(artistId);
        return artist.getEvents().stream()
            .filter(event -> event.getState() == State.CONFIRMED || event.getState() == State.RESCHEDULED).map(EventListResponse::fromEntity).toList();
    }

    public List<ArtistResponse> getArtists(Genre genre) {
        List<Artist> artists = genre != null ? artistRepository.findByGenre(genre) : artistRepository.findAll();
        return artists.stream().map(ArtistResponse::fromEntity).toList();
    }

    public List<ArtistResponse> getPublicArtists() {
        List<Artist> artists = artistRepository.findByActive(true);
        return artists.stream().map(ArtistResponse::fromEntity).toList();
    }
}
