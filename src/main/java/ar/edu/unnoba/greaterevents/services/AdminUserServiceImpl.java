package ar.edu.unnoba.greaterevents.services;

import ar.edu.unnoba.greaterevents.dtos.AdminUserCreateRequest;
import ar.edu.unnoba.greaterevents.dtos.AdminUserResponse;
import ar.edu.unnoba.greaterevents.exceptions.ResourceNotFoundException;
import jakarta.ws.rs.NotFoundException;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AdminUserServiceImpl implements AdminUserService {
    private final KeycloakIntegrationService keycloakIntegrationService;
    private final Keycloak keycloak;
    private final String realm = "unnoba";

    // Métodos auxiliares
    private AdminUserResponse mapToAdminUserResponse(UserRepresentation user) {
        return new AdminUserResponse(user.getId(), user.getUsername(), user.getEmail(), user.getFirstName(), user.getLastName());
    }
    
    // Método de creación
    public AdminUserResponse createAdmin(AdminUserCreateRequest request) {
        return mapToAdminUserResponse(keycloakIntegrationService.createUserInKeycloak(request.username(), request.email(), request.password(), request.firstName(), request.lastName(), "admin"));
    }

    // Método de eliminación
    public void deleteAdmin(String userId) {
        try {
            keycloak.realm(realm).users().get(userId).remove();
        } catch (NotFoundException exception) {
            throw new ResourceNotFoundException("Admin user not found");
        }
    }

    // Métodos de consulta
    public AdminUserResponse getAdminById(String userId) {
        try {
            UserRepresentation user = keycloak.realm(realm).users().get(userId).toRepresentation();
            return mapToAdminUserResponse(user);
        } catch (NotFoundException exception) {
            throw new ResourceNotFoundException("Admin user not found");
        }
    }

    public List<AdminUserResponse> getAdmins() {
        return keycloak.realm(realm).users().list().stream()
            .map(this::mapToAdminUserResponse)
            .toList();
    }
}
