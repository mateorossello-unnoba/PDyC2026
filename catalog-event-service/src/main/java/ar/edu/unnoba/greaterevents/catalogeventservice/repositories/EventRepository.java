package ar.edu.unnoba.greaterevents.catalogeventservice.repositories;

import ar.edu.unnoba.greaterevents.catalogeventservice.models.event.*;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventRepository extends JpaRepository<Event, Long> {
    List<Event> findByState(State state);

    List<Event> findByArtists_IdAndStateIn(Long artistId, List<State> states);
}
