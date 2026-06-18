package ar.edu.unnoba.greaterevents.usersocialservice.dtos.user;

import ar.edu.unnoba.greaterevents.usersocialservice.models.user.User;

public record UserListResponse (
    String username,
    String email
) {
    public static UserListResponse fromEntity(User user) {
        return new UserListResponse(
            user.getUsername(),
            user.getEmail()
        );
    }
}
