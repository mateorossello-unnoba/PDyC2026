package ar.edu.unnoba.greaterevents.usersocialservice.services.user;

import ar.edu.unnoba.greaterevents.usersocialservice.dtos.artist.*;
import ar.edu.unnoba.greaterevents.usersocialservice.dtos.event.*;
import ar.edu.unnoba.greaterevents.usersocialservice.dtos.user.*;
import java.util.List;
import java.util.Set;

/**
 * Interfaz del servicio de usuarios.
 */

public interface UserService {
    // Método de creación.
    UserDetailResponse createUser(UserCreateRequest request);

    // Métodos de actualización.
    UserDetailResponse followArtist(String username, FollowArtistRequest request);
    UserDetailResponse unfollowArtist(String username, Long artistId);
    UserDetailResponse addFavoriteEvent(String username, FavoriteEventRequest request);
    UserDetailResponse removeFavoriteEvent(String username, Long eventId);

    // Métodos de consulta.
    UserDetailResponse getUserById(Long id);
    List<UserListResponse> getUsers();

    List<ArtistResponse> getFollowedArtists(String username);
    List<EventDetailResponse> getFavoriteEvents(String username);
    
    List<EventListResponse> getFutureActiveEventsFromFollowedArtistsOrderedByDate(String username);

    UserListResponse getUserByUsername(String username);
    Set<UserListResponse> getUsersInterestedInEvent(Long eventId, Set<Long> artistIds);
}
