package ar.edu.unnoba.greaterevents.usersocialservice.dtos.admin;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * DTO de solicitud para la creación de un usuario administrador.
 */

public record AdminUserCreateRequest(
    @NotBlank @Size(max = 50) String username,
    @NotBlank @Email @Size(max = 254) String email,
    @NotBlank @Size(min = 8, max = 255) String password,
    @Size(max = 100) String firstName,
    @Size(max = 100) String lastName
) {}
