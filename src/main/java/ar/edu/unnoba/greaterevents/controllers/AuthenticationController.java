package ar.edu.unnoba.greaterevents.controllers;

import ar.edu.unnoba.greaterevents.dtos.user.*;
import ar.edu.unnoba.greaterevents.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
public class AuthenticationController {
    private final UserService userService;

    // Endpoints de actualización
    @PostMapping("/register")
    public ResponseEntity<UserDetailResponse> registerUser(@RequestBody UserCreateRequest request) {
        return ResponseEntity.ok(userService.createUser(request));
    }
}
