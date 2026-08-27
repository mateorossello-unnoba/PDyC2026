package ar.edu.unnoba.greaterevents.usersocialservice.controllers.user;

import ar.edu.unnoba.greaterevents.usersocialservice.dtos.user.*;
import ar.edu.unnoba.greaterevents.usersocialservice.services.user.*;
import java.util.Set;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Controlador interno para la gestión de usuarios, utilizado exclusivamente para la comunicación entre microservicios.
 */

@RestController
@RequiredArgsConstructor
@RequestMapping("/internal/users")
public class InternalUserController {
    private final UserService userService;

    // Endpoint interno para reconstruir DTOs (UserListResponse) a partir de un username.
    @GetMapping("/username/{username}")
    public ResponseEntity<UserListResponse> getUserByUsername(@PathVariable String username) {
        return ResponseEntity.ok(userService.getUserByUsername(username));
    }

    // Endpoint interno para RabbitMQ buscando a quién notificar.
    @GetMapping("/interested")
    public ResponseEntity<Set<UserListResponse>> getUsersInterestedInEvent(@RequestParam Long eventId, @RequestParam Set<Long> artistIds) {
        return ResponseEntity.ok(userService.getUsersInterestedInEvent(eventId, artistIds));
    }
}
