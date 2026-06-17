package ar.edu.unnoba.greaterevents.dtos.admin;

public record AdminUserResponse (
    String id,
    String username,
    String email,
    String firstName,
    String lastName
) {}
