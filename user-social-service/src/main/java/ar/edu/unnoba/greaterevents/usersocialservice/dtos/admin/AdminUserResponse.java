package ar.edu.unnoba.greaterevents.usersocialservice.dtos.admin;

public record AdminUserResponse (
    String id,
    String username,
    String email,
    String firstName,
    String lastName
) {}
