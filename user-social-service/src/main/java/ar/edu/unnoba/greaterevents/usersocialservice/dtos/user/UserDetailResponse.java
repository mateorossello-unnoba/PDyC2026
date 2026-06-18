package ar.edu.unnoba.greaterevents.usersocialservice.dtos.user;

import ar.edu.unnoba.greaterevents.usersocialservice.dtos.artist.ArtistResponse;
import ar.edu.unnoba.greaterevents.usersocialservice.dtos.event.EventListResponse;
import ar.edu.unnoba.greaterevents.usersocialservice.models.user.User;
import java.util.List;

public record UserDetailResponse (
    String username,
    String email,
    List<ArtistResponse> followedArtistResponses,
    List<EventListResponse> favoriteEventResponses
) {
    public static UserDetailResponse fromEntity(User user, List<ArtistResponse> artists, List<EventListResponse> events) {
        return new UserDetailResponse(
            user.getUsername(),
            user.getEmail(),
            artists,
            events
        );
    }
}
