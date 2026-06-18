package ar.edu.unnoba.greaterevents.usersocialservice.dtos.user;

public record UserCreateRequest (
    String username,
    String email,
    String password
) {}
