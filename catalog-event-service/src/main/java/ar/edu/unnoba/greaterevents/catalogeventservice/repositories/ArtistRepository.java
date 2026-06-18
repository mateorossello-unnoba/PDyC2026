package ar.edu.unnoba.greaterevents.catalogeventservice.repositories;

import ar.edu.unnoba.greaterevents.catalogeventservice.models.artist.Artist;
import ar.edu.unnoba.greaterevents.catalogeventservice.models.artist.Genre;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ArtistRepository extends JpaRepository<Artist, Long> {
    List<Artist> findByGenre(Genre genre);
    List<Artist> findByActive(boolean active);
}
