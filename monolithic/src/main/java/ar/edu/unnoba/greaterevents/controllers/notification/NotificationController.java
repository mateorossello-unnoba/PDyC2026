package ar.edu.unnoba.greaterevents.controllers.notification;

import ar.edu.unnoba.greaterevents.dtos.notification.*;
import ar.edu.unnoba.greaterevents.services.notification.*;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/me/notifications")
public class NotificationController {
    private final NotificationService notificationService;

    // Endpoint de actualización
    @PatchMapping("/{id}")
    public ResponseEntity<NotificationDetailResponse> markAsRead(@PathVariable Long id, @RequestBody NotificationUpdateRequest request, @AuthenticationPrincipal Jwt jwt) {
        String username = jwt.getClaimAsString("preferred_username");
        return ResponseEntity.ok(notificationService.markAsRead(username, id, request));
    }

    // Endpoint de eliminación
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteNotification(@PathVariable Long id, @AuthenticationPrincipal Jwt jwt) {
        String username = jwt.getClaimAsString("preferred_username");
        notificationService.deleteNotification(username, id);
        return ResponseEntity.noContent().build();
    }

    // Endpoint de consulta
    @GetMapping
    public ResponseEntity<List<NotificationDetailResponse>> getMyNotifications(@AuthenticationPrincipal Jwt jwt) {
        String username = jwt.getClaimAsString("preferred_username");
        return ResponseEntity.ok(notificationService.getMyNotifications(username));
    }
}
