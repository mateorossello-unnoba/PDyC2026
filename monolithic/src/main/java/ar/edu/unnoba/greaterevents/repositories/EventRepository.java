package ar.edu.unnoba.greaterevents.repositories;

import ar.edu.unnoba.greaterevents.models.event.Event;
import ar.edu.unnoba.greaterevents.models.event.State;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventRepository extends JpaRepository<Event, Long> {
    List<Event> findByState(State state);
}
