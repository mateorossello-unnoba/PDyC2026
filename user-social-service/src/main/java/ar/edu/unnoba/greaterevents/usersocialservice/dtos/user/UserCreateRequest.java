package ar.edu.unnoba.greaterevents.usersocialservice.dtos.user;

/**
 * DTO de solicitud para la creación de un usuario.
 */

public record UserCreateRequest (
    String username,
    String email,
    String password
) {}
