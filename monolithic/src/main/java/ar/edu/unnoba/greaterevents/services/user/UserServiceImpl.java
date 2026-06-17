package ar.edu.unnoba.greaterevents.services.user;

import ar.edu.unnoba.greaterevents.dtos.artist.ArtistResponse;
import ar.edu.unnoba.greaterevents.dtos.event.EventDetailResponse;
import ar.edu.unnoba.greaterevents.dtos.user.*;
import ar.edu.unnoba.greaterevents.exceptions.ResourceNotFoundException;
import ar.edu.unnoba.greaterevents.models.event.Event;
import ar.edu.unnoba.greaterevents.models.event.State;
import ar.edu.unnoba.greaterevents.models.user.*;
import ar.edu.unnoba.greaterevents.repositories.UserRepository;
import ar.edu.unnoba.greaterevents.services.KeycloakIntegrationService;
import ar.edu.unnoba.greaterevents.services.artist.ArtistServiceImpl;
import ar.edu.unnoba.greaterevents.services.event.EventServiceImpl;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final ArtistServiceImpl artistService;
    private final EventServiceImpl eventService;
    private final KeycloakIntegrationService keycloakIntegrationService;

    // Métodos auxiliares
    public User getUserByIdOrThrow(Long id) {
        return userRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("User not found"));
    }

    public User getUserByUsernameOrThrow(String username) {
        return userRepository.findByUsernameIgnoreCase(username).orElseThrow(() -> new ResourceNotFoundException("User not found"));
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
        return UserDetailResponse.fromEntity(localUser);
    }

    // Métodos de actualización
    public UserDetailResponse followArtist(String username, FollowArtistRequest request) {
        User user = getUserByUsernameOrThrow(username);
        user.getFollowedArtists().add(artistService.getArtistByIdOrThrow(request.artistId()));
        userRepository.save(user);
        return UserDetailResponse.fromEntity(user);
    }

    public UserDetailResponse unfollowArtist(String username, Long artistId) {
        User user = getUserByUsernameOrThrow(username);
        user.getFollowedArtists().removeIf(artist -> artist.getId().equals(artistId));
        userRepository.save(user);
        return UserDetailResponse.fromEntity(user);
    }

    public UserDetailResponse addFavoriteEvent(String username, FavoriteEventRequest request) {
        User user = getUserByUsernameOrThrow(username);
        user.getFavoriteEvents().add(eventService.getEventByIdOrThrow(request.eventId()));
        userRepository.save(user);
        return UserDetailResponse.fromEntity(user);
    }

    public UserDetailResponse removeFavoriteEvent(String username, Long eventId) {
        User user = getUserByUsernameOrThrow(username);
        user.getFavoriteEvents().removeIf(event -> event.getId().equals(eventId));
        userRepository.save(user);
        return UserDetailResponse.fromEntity(user);
    }

    // Métodos de consulta
    public UserDetailResponse getUserById(Long id) {
        return UserDetailResponse.fromEntity(getUserByIdOrThrow(id));
    }

    public List<UserListResponse> getUsers() {
        return userRepository.findAll().stream().map(UserListResponse::fromEntity).toList();
    }

    public List<ArtistResponse> getFollowedArtists(String username) {
        User user = getUserByUsernameOrThrow(username);
        return user.getFollowedArtists().stream().map(ArtistResponse::fromEntity).toList();
    }

    public List<EventDetailResponse> getFavoriteEvents(String username) {
        User user = getUserByUsernameOrThrow(username);
        return user.getFavoriteEvents().stream()
            .filter(event -> !event.getStartDate().isBefore(LocalDate.now()) && event.getState() != State.CANCELLED && event.getState() != State.TENTATIVE)
            .map(EventDetailResponse::fromEntity)
            .toList();
    }

    public List<EventDetailResponse> getFutureActiveEventsFromFollowedArtistsOrderedByDate(String username) {
        User user = getUserByUsernameOrThrow(username);
        return user.getFollowedArtists().stream()
            .flatMap(artist -> artist.getEvents().stream())
            .distinct()
            .filter(event -> !event.getStartDate().isBefore(LocalDate.now()) && event.getState() != State.CANCELLED && event.getState() != State.TENTATIVE)
            .sorted(Comparator.comparing(Event::getStartDate))
            .map(EventDetailResponse::fromEntity)
            .toList();
    }
}
