package ar.edu.unnoba.greaterevents.notificationservice.dtos.user;

/**
 * DTO de respuesta resumida para un usuario.
 */

public record UserListResponse (
    String username,
    String email
) {}
