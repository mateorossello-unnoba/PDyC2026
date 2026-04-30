package ar.edu.unnoba.greaterevents.repositories;

import ar.edu.unnoba.greaterevents.models.event.Event;
import ar.edu.unnoba.greaterevents.models.event.State;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EventRepository extends JpaRepository<Event, Long> {
    List<Event> findByState(State state);
}
