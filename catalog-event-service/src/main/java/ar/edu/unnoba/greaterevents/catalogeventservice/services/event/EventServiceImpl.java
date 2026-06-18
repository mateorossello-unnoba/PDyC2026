package ar.edu.unnoba.greaterevents.catalogeventservice.services.event;

import ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.exceptions.ResourceNotFoundException;
import ar.edu.unnoba.greaterevents.catalogeventservice.models.artist.Artist;
import ar.edu.unnoba.greaterevents.catalogeventservice.models.event.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.repositories.EventRepository;
import ar.edu.unnoba.greaterevents.catalogeventservice.services.artist.ArtistServiceImpl;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Stream;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {
    private final EventRepository eventRepository;
    private final ArtistServiceImpl artistService;

    // Método auxiliar
    public Event getEventByIdOrThrow(Long id) {
        return eventRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Event not found"));
    }

    private void notifyEventChange(Event event, State previousState) {
        // TODO: Comunicación asíncrona publicando un mensaje en el Broker con el event.getId(), previousState y event.getState()

        System.out.println("Event change notification sent for event " + event.getId() + " with previous state " + previousState + " and new state " + event.getState());
    }

    // Implementación de métodos de la interfaz
    // Método de creación
    public EventDetailResponse createEvent(EventCreateRequest request) {
        Event event = new Event();
        
        event.setName(request.name());
        event.setDescription(request.description());
        event.setStartDate(request.startDate());
        
        eventRepository.save(event);
        return EventDetailResponse.fromEntity(event);
    }

    // Métodos de actualización
    public EventDetailResponse updateEvent(Long id, EventCreateRequest request) {
        Event event = getEventByIdOrThrow(id);

        if (event.getState() != State.TENTATIVE) {
            throw new IllegalStateException("Only tentative events can be updated");
        }

        event.setName(request.name());
        event.setDescription(request.description());
        event.setStartDate(request.startDate());

        eventRepository.save(event);
        return EventDetailResponse.fromEntity(event);
    }

    public EventDetailResponse cancelEvent(Long eventId) {
        Event event = getEventByIdOrThrow(eventId);
        State previousState = event.getState();

        if (event.getState() == State.CONFIRMED || event.getState() == State.RESCHEDULED) {
            event.setState(State.CANCELLED);
        } else {
            throw new IllegalStateException("Only confirmed or rescheduled events can be cancelled");
        }

        eventRepository.save(event);
        notifyEventChange(event, previousState);
        return EventDetailResponse.fromEntity(event);
    }

    public EventDetailResponse confirmEvent(Long eventId) {
        Event event = getEventByIdOrThrow(eventId);

        if (event.getState() != State.TENTATIVE || !event.getStartDate().isAfter(LocalDate.now())) {
            throw new IllegalStateException("Only tentative events with a future start date can be confirmed");
        }

        State previousState = event.getState();
        event.setState(State.CONFIRMED);

        eventRepository.save(event);
        notifyEventChange(event, previousState);
        return EventDetailResponse.fromEntity(event);
    }

    public EventDetailResponse rescheduleEvent(Long eventId, EventRescheduleRequest request) {
        Event event = getEventByIdOrThrow(eventId);

        if (event.getState() != State.CONFIRMED && event.getState() != State.RESCHEDULED) {
            throw new IllegalStateException("Only confirmed or rescheduled events can be rescheduled");
        }

        if (event.getStartDate().isBefore(LocalDate.now())) {
            throw new IllegalStateException("Only events that have not happened yet can be rescheduled");
        }

        if (!request.startDate().isAfter(LocalDate.now())) {
            throw new IllegalStateException("Rescheduled date must be in the future");
        }

        State previousState = event.getState();
        event.setState(State.RESCHEDULED);
        event.setStartDate(request.startDate());

        eventRepository.save(event);
        notifyEventChange(event, previousState);
        return EventDetailResponse.fromEntity(event);
    }

    public void addArtistToEvent(Long eventId, EventAddArtistRequest request) {
        Artist artist = artistService.getArtistByIdOrThrow(request.artistId());
        
        if (!artist.isActive()) {
            throw new IllegalStateException("Cannot add an inactive artist to an event");
        }

        Event event = getEventByIdOrThrow(eventId);

        if (event.getState() != State.TENTATIVE) {
            throw new IllegalStateException("Artists can only be added to tentative events");
        }

        event.getArtists().add(artist);
        eventRepository.save(event);
    }

    public void removeArtistFromEvent(Long eventId, Long artistId) {
        Event event = getEventByIdOrThrow(eventId);

        if (event.getState() != State.TENTATIVE) {
            throw new IllegalStateException("Artists can only be removed from tentative events");
        }

        event.getArtists().removeIf(artist -> artist.getId().equals(artistId));
        eventRepository.save(event);
    }

    // Método de eliminación
    public void deleteEvent(Long id) {
        Event event = getEventByIdOrThrow(id);

        if (event.getState() == State.TENTATIVE) {
            eventRepository.delete(event);
        } else {
            throw new IllegalStateException("Only tentative events can be deleted");
        }
    }

    // Métodos de consulta
    public EventDetailResponse getEventById(Long id) {
        return EventDetailResponse.fromEntity(getEventByIdOrThrow(id));
    }

    public EventDetailResponse getPublicEventById(Long id) {
        Event event = getEventByIdOrThrow(id);

        if (event.getState() == State.TENTATIVE) {
            throw new ResourceNotFoundException("Event not found");
        }

        return EventDetailResponse.fromEntity(event);
    }

    public List<EventListResponse> getEvents(State state) {
        List<Event> events = (state != null) ? eventRepository.findByState(state) : eventRepository.findAll();
        return events.stream().map(EventListResponse::fromEntity).toList();
    }

    public List<EventListResponse> getPublicEvents() {
        List<Event> confirmedEvents = eventRepository.findByState(State.CONFIRMED);
        List<Event> rescheduledEvents = eventRepository.findByState(State.RESCHEDULED);

        return Stream.concat(confirmedEvents.stream(), rescheduledEvents.stream()).map(EventListResponse::fromEntity).toList();
    }

    public EventListResponse getPublicEventSummaryById(Long id) {
        Event event = getEventByIdOrThrow(id);

        if (event.getState() == State.TENTATIVE) {
            throw new ResourceNotFoundException("Event not found");
        }

        return EventListResponse.fromEntity(event);
    }

    public List<EventListResponse> getPublicEventsByArtistId(Long artistId) {
        List<Event> events = eventRepository.findByArtists_IdAndStateIn(artistId, List.of(State.CONFIRMED, State.RESCHEDULED));
        return events.stream().map(EventListResponse::fromEntity).toList();
    }
}
