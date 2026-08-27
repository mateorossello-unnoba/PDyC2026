package ar.edu.unnoba.greaterevents.usersocialservice.services.admin;

import ar.edu.unnoba.greaterevents.usersocialservice.dtos.admin.*;
import ar.edu.unnoba.greaterevents.usersocialservice.exceptions.ResourceNotFoundException;
import ar.edu.unnoba.greaterevents.usersocialservice.services.KeycloakIntegrationService;
import jakarta.ws.rs.NotFoundException;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.stereotype.Service;

/**
 * Implementación del servicio de usuarios administradores.
 */

@Service
@RequiredArgsConstructor
public class AdminUserServiceImpl implements AdminUserService {
    private final KeycloakIntegrationService keycloakIntegrationService;
    private final Keycloak keycloak;
    private static final String REALM = "unnoba";

    // Método auxiliar.
    private AdminUserResponse mapToAdminUserResponse(UserRepresentation user) {
        return new AdminUserResponse(user.getId(), user.getUsername(), user.getEmail(), user.getFirstName(), user.getLastName());
    }
    
    //
    // Implementación de métodos de la interfaz.
    //
    
    // Método de creación.
    public AdminUserResponse createAdmin(AdminUserCreateRequest request) {
        return mapToAdminUserResponse(keycloakIntegrationService.createUserInKeycloak(request.username(), request.email(), request.password(), request.firstName(), request.lastName(), "admin"));
    }

    // Método de eliminación.
    public void deleteAdmin(String userId) {
        try {
            keycloak.realm(REALM).users().get(userId).remove();
        } catch (NotFoundException exception) {
            throw new ResourceNotFoundException("Admin user not found.");
        }
    }

    // Métodos de consulta.
    public AdminUserResponse getAdminById(String userId) {
        try {
            UserRepresentation user = keycloak.realm(REALM).users().get(userId).toRepresentation();
            return mapToAdminUserResponse(user);
        } catch (NotFoundException exception) {
            throw new ResourceNotFoundException("Admin user not found.");
        }
    }

    public List<AdminUserResponse> getAdmins() {
        return keycloak.realm(REALM).users().list().stream().map(this::mapToAdminUserResponse).toList();
    }
}
