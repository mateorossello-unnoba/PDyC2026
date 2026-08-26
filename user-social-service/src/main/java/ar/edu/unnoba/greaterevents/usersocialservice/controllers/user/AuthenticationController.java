package ar.edu.unnoba.greaterevents.usersocialservice.controllers.user;

import ar.edu.unnoba.greaterevents.usersocialservice.dtos.user.*;
import ar.edu.unnoba.greaterevents.usersocialservice.services.user.*;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Controlador para la autenticación de usuarios.
 */

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
public class AuthenticationController {
    private final UserService userService;

    // Endpoint de creación.
    @PostMapping("/register")
    public ResponseEntity<UserDetailResponse> registerUser(@Valid @RequestBody UserCreateRequest request) {
        return ResponseEntity.ok(userService.createUser(request));
    }
}
