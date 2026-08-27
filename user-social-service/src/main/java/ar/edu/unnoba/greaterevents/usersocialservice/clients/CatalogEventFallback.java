package ar.edu.unnoba.greaterevents.usersocialservice.clients;

import ar.edu.unnoba.greaterevents.usersocialservice.dtos.artist.*;
import ar.edu.unnoba.greaterevents.usersocialservice.dtos.event.*;
import java.util.Collections;
import java.util.List;
import org.springframework.stereotype.Component;

/**
 * Permite devolver valores por defecto para artistas y eventos en caso de que catalog-event-service no esté disponible.
 */

@Component
public class CatalogEventFallback implements CatalogEventClient {
    //TODO: Puede ser reemplazado por un Fallback Factory para devolver una respuesta más detallada en caso de error.

    @Override
    public ArtistResponse getArtistById(Long id) {
        return null;
    }

    @Override
    public EventDetailResponse getEventById(Long id) {
        return null;
    }

    @Override
    public EventListResponse getEventSummaryById(Long id) {
        return null;
    }

    @Override
    public List<EventListResponse> getEventsByArtistId(Long artistId) {
        return Collections.emptyList();
    }
}
