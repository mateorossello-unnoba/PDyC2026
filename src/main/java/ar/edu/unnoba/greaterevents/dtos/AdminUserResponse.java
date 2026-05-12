package ar.edu.unnoba.greaterevents.dtos;

public record AdminUserResponse (
    String username,
    String email,
    String firstName,
    String lastName
) {}
