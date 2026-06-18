package ar.edu.unnoba.greaterevents.catalogeventservice.services.event;

import ar.edu.unnoba.greaterevents.catalogeventservice.dtos.event.*;
import ar.edu.unnoba.greaterevents.catalogeventservice.models.event.*;
import java.util.List;

public interface EventService {
    // Método de creación
    EventDetailResponse createEvent(EventCreateRequest request);

    // Métodos de actualización
    EventDetailResponse updateEvent(Long id, EventCreateRequest request);
    EventDetailResponse cancelEvent(Long eventId);
    EventDetailResponse confirmEvent(Long eventId);
    EventDetailResponse rescheduleEvent(Long eventId, EventRescheduleRequest request);
    void addArtistToEvent(Long eventId, EventAddArtistRequest request);
    void removeArtistFromEvent(Long eventId, Long artistId);

    // Método de eliminación
    void deleteEvent(Long id);

    // Métodos de consulta
    EventDetailResponse getEventById(Long id);
    EventDetailResponse getPublicEventById(Long id);
    List<EventListResponse> getEvents(State state);
    List<EventListResponse> getPublicEvents();

    EventListResponse getPublicEventSummaryById(Long id);

    List<EventListResponse> getPublicEventsByArtistId(Long artistId);
}
