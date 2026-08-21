package ar.edu.unnoba.greaterevents.usersocialservice.dtos.admin;

/**
 * DTO de respuesta para un usuario administrador.
 */

public record AdminUserResponse (
    String id,
    String username,
    String email,
    String firstName,
    String lastName
) {}
