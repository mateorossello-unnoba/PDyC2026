package ar.edu.unnoba.greaterevents.usersocialservice.services.user;

import ar.edu.unnoba.greaterevents.usersocialservice.clients.CatalogEventClient;
import ar.edu.unnoba.greaterevents.usersocialservice.dtos.artist.*;
import ar.edu.unnoba.greaterevents.usersocialservice.dtos.event.*;
import ar.edu.unnoba.greaterevents.usersocialservice.dtos.user.*;
import ar.edu.unnoba.greaterevents.usersocialservice.exceptions.ResourceNotFoundException;
import ar.edu.unnoba.greaterevents.usersocialservice.models.event.*;
import ar.edu.unnoba.greaterevents.usersocialservice.models.user.*;
import ar.edu.unnoba.greaterevents.usersocialservice.repositories.UserRepository;
import ar.edu.unnoba.greaterevents.usersocialservice.services.KeycloakIntegrationService;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final CatalogEventClient catalogEventClient;
    private final KeycloakIntegrationService keycloakIntegrationService;

    // Métodos auxiliares
    public User getUserByIdOrThrow(Long id) {
        return userRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("User not found"));
    }

    public User getUserByUsernameOrThrow(String username) {
        return userRepository.findByUsernameIgnoreCase(username).orElseThrow(() -> new ResourceNotFoundException("User not found"));
    }

    private UserDetailResponse buildUserDetailResponse(User user) {
        List<ArtistResponse> artists = user.getFollowedArtists().stream().map(catalogEventClient::getArtistById).toList();
        List<EventListResponse> events = user.getFavoriteEvents().stream().map(catalogEventClient::getEventSummaryById).toList();

        return UserDetailResponse.fromEntity(user, artists, events);
    }

    // Implementación de métodos de la interfaz
    // Método de creación
    public UserDetailResponse createUser(UserCreateRequest request) {
        if (userRepository.findByUsernameIgnoreCase(request.username()).isPresent()) {
            throw new IllegalArgumentException("Username already exists");
        }

        if (userRepository.findByEmail(request.email()).isPresent()) {
            throw new IllegalArgumentException("Email already exists");
        }

        keycloakIntegrationService.createUserInKeycloak(request.username(), request.email(), request.password(), null, null, null);
            
        User localUser = new User();

        localUser.setUsername(request.username().toLowerCase());
        localUser.setEmail(request.email().toLowerCase());

        localUser = userRepository.save(localUser);
        return UserDetailResponse.fromEntity(localUser, List.of(), List.of());
    }

    // Métodos de actualización
    public UserDetailResponse followArtist(String username, FollowArtistRequest request) {
        User user = getUserByUsernameOrThrow(username);
        ArtistResponse artist = catalogEventClient.getArtistById(request.artistId());

        if (!user.getFollowedArtists().contains(artist.id())) {
            user.getFollowedArtists().add(request.artistId());
            userRepository.save(user);
        }

        userRepository.save(user);
        return buildUserDetailResponse(user);
    }

    public UserDetailResponse unfollowArtist(String username, Long artistId) {
        User user = getUserByUsernameOrThrow(username);
        user.getFollowedArtists().removeIf(id -> id.equals(artistId));
        userRepository.save(user);
        return buildUserDetailResponse(user);
    }

    public UserDetailResponse addFavoriteEvent(String username, FavoriteEventRequest request) {
        User user = getUserByUsernameOrThrow(username);
        EventDetailResponse event = catalogEventClient.getEventById(request.eventId());

        if (!user.getFavoriteEvents().contains(event.id())) {
            user.getFavoriteEvents().add(request.eventId());
            userRepository.save(user);
        }
        
        return buildUserDetailResponse(user);
    }

    public UserDetailResponse removeFavoriteEvent(String username, Long eventId) {
        User user = getUserByUsernameOrThrow(username);
        user.getFavoriteEvents().removeIf(id -> id.equals(eventId));
        userRepository.save(user);
        return buildUserDetailResponse(user);
    }

    // Métodos de consulta
    public UserDetailResponse getUserById(Long id) {
        return buildUserDetailResponse(getUserByIdOrThrow(id));
    }

    public List<UserListResponse> getUsers() {
        return userRepository.findAll().stream().map(UserListResponse::fromEntity).toList();
    }

    public List<ArtistResponse> getFollowedArtists(String username) {
        User user = getUserByUsernameOrThrow(username);
        return user.getFollowedArtists().stream().map(catalogEventClient::getArtistById).toList();
    }

    public List<EventDetailResponse> getFavoriteEvents(String username) {
        User user = getUserByUsernameOrThrow(username);
        return user.getFavoriteEvents().stream()
            .map(catalogEventClient::getEventById)
            .filter(event -> !event.startDate().isBefore(LocalDate.now()) && !event.state().equals(State.CANCELLED.toString()) && !event.state().equals(State.TENTATIVE.toString()))
            .toList();
    }

    public List<EventListResponse> getFutureActiveEventsFromFollowedArtistsOrderedByDate(String username) {
        User user = getUserByUsernameOrThrow(username);
        return user.getFollowedArtists().stream()
            .flatMap(artistId -> catalogEventClient.getEventsByArtistId(artistId).stream())
            .distinct()
            .filter(event -> !event.startDate().isBefore(LocalDate.now()) && !event.state().equals(State.CANCELLED.toString()) && !event.state().equals(State.TENTATIVE.toString()))
            .sorted(Comparator.comparing(EventListResponse::startDate))
            .toList();
    }

    public UserListResponse getUserByUsername(String username) {
        return UserListResponse.fromEntity(getUserByUsernameOrThrow(username));
    }

    public Set<UserListResponse> getUsersInterestedInEvent(Long eventId, Set<Long> artistIds) {
        return userRepository.findUsersToNotifyAboutEvent(eventId, artistIds).stream().map(UserListResponse::fromEntity).collect(Collectors.toSet());
    }
}
