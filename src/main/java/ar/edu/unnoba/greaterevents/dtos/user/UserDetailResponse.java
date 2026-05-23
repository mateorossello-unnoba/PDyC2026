package ar.edu.unnoba.greaterevents.dtos.user;

import ar.edu.unnoba.greaterevents.dtos.artist.ArtistResponse;
import ar.edu.unnoba.greaterevents.dtos.event.EventListResponse;
import ar.edu.unnoba.greaterevents.models.user.User;
import java.util.List;

public record UserDetailResponse (
    String username,
    String email,
    List<ArtistResponse> followedArtistResponses,
    List<EventListResponse> favoriteEventResponses
) {
    public static UserDetailResponse fromEntity(User user) {
        return new UserDetailResponse(
            user.getUsername(),
            user.getEmail(),
            user.getFollowedArtists().stream().map(ArtistResponse::fromEntity).toList(),
            user.getFavoriteEvents().stream().map(EventListResponse::fromEntity).toList()
        );
    }
}
