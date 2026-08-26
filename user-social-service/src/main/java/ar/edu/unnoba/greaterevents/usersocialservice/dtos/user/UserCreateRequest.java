package ar.edu.unnoba.greaterevents.usersocialservice.dtos.user;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * DTO de solicitud para la creación de un usuario.
 */

public record UserCreateRequest (
    @NotBlank @Size(max = 50) String username,
    @NotBlank @Email @Size(max = 254) String email,
    @NotBlank @Size(min = 8, max = 255) String password
) {}
