package ar.edu.unnoba.greaterevents.notificationservice.clients;

import ar.edu.unnoba.greaterevents.notificationservice.dtos.user.*;
import java.util.Set;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Permite interactuar con user-social-service y obtener información sobre usuarios.
 */

@FeignClient(name = "user-social-service", fallback = UserSocialFallback.class)
public interface UserSocialClient {
    // Método para obtener un usuario por su nombre de usuario.
    @GetMapping("/internal/users/username/{username}")
    UserListResponse getUserByUsername(@PathVariable("username") String username);

    // Método para obtener los usuarios interesados en un evento dado su ID y los IDs de los artistas.
    @GetMapping("/internal/users/interested")
    Set<UserListResponse> getInterestedUsers(@RequestParam("eventId") Long eventId, @RequestParam("artistIds") Set<Long> artistIds);
}
