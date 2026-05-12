package ar.edu.unnoba.greaterevents.controllers;

import ar.edu.unnoba.greaterevents.dtos.AdminUserCreateRequest;
import ar.edu.unnoba.greaterevents.dtos.AdminUserResponse;
import ar.edu.unnoba.greaterevents.services.AdminUserService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin/users")
public class AdminUserController {
    private final AdminUserService adminService;

    // Endpoint de creación
    @PostMapping
    public ResponseEntity<AdminUserResponse> createAdmin(@RequestBody AdminUserCreateRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(adminService.createAdmin(request));
    }

    // Endpoint de eliminación
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAdmin(@PathVariable String id) {
        adminService.deleteAdmin(id);
        return ResponseEntity.noContent().build();
    }

    // Endpoints de consulta
    @GetMapping("/{id}")
    public ResponseEntity<AdminUserResponse> getAdminById(@PathVariable String id) {
        return ResponseEntity.ok(adminService.getAdminById(id));
    }

    @GetMapping
    public ResponseEntity<List<AdminUserResponse>> getAdmins() {
        return ResponseEntity.ok(adminService.getAdmins());
    }
}
