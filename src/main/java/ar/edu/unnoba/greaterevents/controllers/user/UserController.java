package ar.edu.unnoba.greaterevents.controllers.user;

import ar.edu.unnoba.greaterevents.dtos.artist.ArtistResponse;
import ar.edu.unnoba.greaterevents.dtos.event.EventDetailResponse;
import ar.edu.unnoba.greaterevents.dtos.user.*;
import ar.edu.unnoba.greaterevents.services.user.*;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/me")
public class UserController {
    private final UserService userService;

    // Métodos auxiliares
    private String getAuthenticatedUsername() {
        Jwt jwt = (Jwt) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        
        String username = jwt.getClaimAsString("preferred_username");

        return username;
    }

    // Endpoints de actualización
    @PostMapping("/following")
    public ResponseEntity<UserDetailResponse> followArtist(@RequestBody FollowArtistRequest request) {
        String username = getAuthenticatedUsername();
        return ResponseEntity.ok(userService.followArtist(username, request));
    }

    @DeleteMapping("/following/{artistId}")
    public ResponseEntity<UserDetailResponse> unfollowArtist(@PathVariable Long artistId) {
        String username = getAuthenticatedUsername();
        return ResponseEntity.ok(userService.unfollowArtist(username, artistId));
    }

    @PostMapping("/favorite-events")
    public ResponseEntity<UserDetailResponse> addFavoriteEvent(@RequestBody FavoriteEventRequest request) {
        String username = getAuthenticatedUsername();
        return ResponseEntity.ok(userService.addFavoriteEvent(username, request));
    }

    @DeleteMapping("/favorite-events/{eventId}")
    public ResponseEntity<UserDetailResponse> removeFavoriteEvent(@PathVariable Long eventId) {
        String username = getAuthenticatedUsername();
        return ResponseEntity.ok(userService.removeFavoriteEvent(username, eventId));
    }

    // Endpoints de consulta
    @GetMapping("/following")
    public ResponseEntity<List<ArtistResponse>> getFollowedArtists() {
        String username = getAuthenticatedUsername();
        return ResponseEntity.ok(userService.getFollowedArtists(username));
    }

    @GetMapping("/favorite-events")
    public ResponseEntity<List<EventDetailResponse>> getFavoriteEvents() {
        String username = getAuthenticatedUsername();
        return ResponseEntity.ok(userService.getFavoriteEvents(username));
    }

    @GetMapping("/following/events")
    public ResponseEntity<List<EventDetailResponse>> getFutureActiveEventsFromFollowedArtistsOrderedByDate() {
        String username = getAuthenticatedUsername();
        return ResponseEntity.ok(userService.getFutureActiveEventsFromFollowedArtistsOrderedByDate(username));
    }
}
