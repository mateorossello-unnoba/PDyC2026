package ar.edu.unnoba.greaterevents.services;

import ar.edu.unnoba.greaterevents.dtos.AdminUserCreateRequest;
import ar.edu.unnoba.greaterevents.dtos.AdminUserResponse;
import ar.edu.unnoba.greaterevents.exceptions.ResourceAlreadyExistsException;
import ar.edu.unnoba.greaterevents.exceptions.ResourceNotFoundException;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.NotFoundException;
import java.util.Collections;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AdminUserServiceImpl implements AdminUserService {
    private final Keycloak keycloak;
    private final String realm = "unnoba";

    // Métodos auxiliares
    private AdminUserResponse mapToAdminUserResponse(UserRepresentation user) {
        return new AdminUserResponse(user.getUsername(), user.getEmail(), user.getFirstName(), user.getLastName());
    }
    
    // Método de creación
    public AdminUserResponse createAdmin(AdminUserCreateRequest request) {
        UserRepresentation user = new UserRepresentation();
        user.setUsername(request.username());
        user.setEmail(request.email());
        user.setFirstName(request.firstName());
        user.setLastName(request.lastName());
        user.setEnabled(true);
        
        CredentialRepresentation credential = new CredentialRepresentation();
        credential.setType(CredentialRepresentation.PASSWORD);
        credential.setValue(request.password());
        credential.setTemporary(false);
        user.setCredentials(Collections.singletonList(credential));

        Response response = keycloak.realm(realm).users().create(user);

        if (response.getStatus() == 409) {
            throw new ResourceAlreadyExistsException("Admin user with the same username already exists");
        }

        return mapToAdminUserResponse(user);
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
