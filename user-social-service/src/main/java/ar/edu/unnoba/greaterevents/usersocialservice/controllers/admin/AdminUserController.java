package ar.edu.unnoba.greaterevents.usersocialservice.controllers.admin;

import ar.edu.unnoba.greaterevents.usersocialservice.dtos.admin.*;
import ar.edu.unnoba.greaterevents.usersocialservice.services.admin.*;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Controlador para la gestión de usuarios administradores.
 */

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin/users")
public class AdminUserController {
    private final AdminUserService adminUserService;

    // Endpoint de creación.
    @PostMapping
    public ResponseEntity<AdminUserResponse> createAdmin(@RequestBody AdminUserCreateRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(adminUserService.createAdmin(request));
    }

    // Endpoint de eliminación.
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAdmin(@PathVariable String id) {
        adminUserService.deleteAdmin(id);
        return ResponseEntity.noContent().build();
    }

    // Endpoints de consulta.
    @GetMapping("/{id}")
    public ResponseEntity<AdminUserResponse> getAdminById(@PathVariable String id) {
        return ResponseEntity.ok(adminUserService.getAdminById(id));
    }

    @GetMapping
    public ResponseEntity<List<AdminUserResponse>> getAdmins() {
        return ResponseEntity.ok(adminUserService.getAdmins());
    }
}
