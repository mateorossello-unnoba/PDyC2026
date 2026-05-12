package ar.edu.unnoba.greaterevents.dtos;

public record AdminUserCreateRequest(
    String username,
    String email,
    String password,
    String firstName,
    String lastName
) {}
