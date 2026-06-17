package ar.edu.unnoba.greaterevents.dtos.admin;

public record AdminUserCreateRequest(
    String username,
    String email,
    String password,
    String firstName,
    String lastName
) {}
