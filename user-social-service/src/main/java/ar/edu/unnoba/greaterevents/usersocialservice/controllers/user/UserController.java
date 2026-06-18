package ar.edu.unnoba.greaterevents.usersocialservice.controllers.user;

import ar.edu.unnoba.greaterevents.usersocialservice.dtos.artist.*;
import ar.edu.unnoba.greaterevents.usersocialservice.dtos.event.*;
import ar.edu.unnoba.greaterevents.usersocialservice.dtos.user.*;
import ar.edu.unnoba.greaterevents.usersocialservice.services.user.*;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/me")
public class UserController {
    private final UserService userService;

    // Endpoints de actualización
    @PostMapping("/following")
    public ResponseEntity<UserDetailResponse> followArtist(@RequestBody FollowArtistRequest request, @AuthenticationPrincipal Jwt jwt) {
        return ResponseEntity.ok(userService.followArtist(jwt.getClaimAsString("preferred_username"), request));
    }

    @DeleteMapping("/following/{artistId}")
    public ResponseEntity<UserDetailResponse> unfollowArtist(@PathVariable Long artistId, @AuthenticationPrincipal Jwt jwt) {
        return ResponseEntity.ok(userService.unfollowArtist(jwt.getClaimAsString("preferred_username"), artistId));
    }

    @PostMapping("/favorite-events")
    public ResponseEntity<UserDetailResponse> addFavoriteEvent(@RequestBody FavoriteEventRequest request, @AuthenticationPrincipal Jwt jwt) {
        return ResponseEntity.ok(userService.addFavoriteEvent(jwt.getClaimAsString("preferred_username"), request));
    }

    @DeleteMapping("/favorite-events/{eventId}")
    public ResponseEntity<UserDetailResponse> removeFavoriteEvent(@PathVariable Long eventId, @AuthenticationPrincipal Jwt jwt) {
        return ResponseEntity.ok(userService.removeFavoriteEvent(jwt.getClaimAsString("preferred_username"), eventId));
    }

    // Endpoints de consulta
    @GetMapping("/following")
    public ResponseEntity<List<ArtistResponse>> getFollowedArtists(@AuthenticationPrincipal Jwt jwt) {
        return ResponseEntity.ok(userService.getFollowedArtists(jwt.getClaimAsString("preferred_username")));
    }

    @GetMapping("/favorite-events")
    public ResponseEntity<List<EventDetailResponse>> getFavoriteEvents(@AuthenticationPrincipal Jwt jwt) {
        return ResponseEntity.ok(userService.getFavoriteEvents(jwt.getClaimAsString("preferred_username")));
    }

    @GetMapping("/following/events")
    public ResponseEntity<List<EventListResponse>> getFutureActiveEventsFromFollowedArtistsOrderedByDate(@AuthenticationPrincipal Jwt jwt) {
        return ResponseEntity.ok(userService.getFutureActiveEventsFromFollowedArtistsOrderedByDate(jwt.getClaimAsString("preferred_username")));
    }
}
