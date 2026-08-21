package ar.edu.unnoba.greaterevents.usersocialservice.dtos.admin;

/**
 * DTO de solicitud para la creación de un usuario administrador.
 */

public record AdminUserCreateRequest(
    String username,
    String email,
    String password,
    String firstName,
    String lastName
) {}
