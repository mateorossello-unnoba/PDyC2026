package ar.edu.unnoba.greaterevents.services;

import ar.edu.unnoba.greaterevents.dtos.artist.ArtistResponse;
import ar.edu.unnoba.greaterevents.dtos.event.EventDetailResponse;
import ar.edu.unnoba.greaterevents.dtos.user.*;
import java.util.List;

public interface UserService {
    // Método de creación
    UserDetailResponse createUser(UserCreateRequest request);

    // Método de actualización
    UserDetailResponse followArtist(String username, FollowArtistRequest request);
    UserDetailResponse unfollowArtist(String username, Long artistId);
    UserDetailResponse addFavoriteEvent(String username, FavoriteEventRequest request);
    UserDetailResponse removeFavoriteEvent(String username, Long eventId);

    // Métodos de consulta
    UserDetailResponse getUserById(Long id);
    List<UserListResponse> getUsers();
    List<ArtistResponse> getFollowedArtists(String username);
    List<EventDetailResponse> getFavoriteEvents(String username);
    List<EventDetailResponse> getFutureActiveEventsFromFollowedArtistsOrderedByDate(String username);
}
