package ar.edu.unnoba.greaterevents.repositories;

import ar.edu.unnoba.greaterevents.models.artist.Artist;
import ar.edu.unnoba.greaterevents.models.artist.Genre;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ArtistRepository extends JpaRepository<Artist, Long> {
    List<Artist> findByGenre(Genre genre);
}
