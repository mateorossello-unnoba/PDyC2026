package ar.edu.unnoba.greaterevents.usersocialservice.dtos.admin;

public record AdminUserCreateRequest(
    String username,
    String email,
    String password,
    String firstName,
    String lastName
) {}
