package ar.edu.unnoba.greaterevents.dtos.user;

public record UserCreateRequest (
    String username,
    String email,
    String password
) {}
