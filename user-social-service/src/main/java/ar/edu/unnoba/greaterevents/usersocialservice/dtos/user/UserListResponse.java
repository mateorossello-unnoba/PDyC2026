package ar.edu.unnoba.greaterevents.usersocialservice.dtos.user;

import ar.edu.unnoba.greaterevents.usersocialservice.models.user.User;

/**
 * DTO de respuesta resumida para un usuario.
 */

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
