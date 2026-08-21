package ar.edu.unnoba.greaterevents.usersocialservice.services;

import ar.edu.unnoba.greaterevents.usersocialservice.exceptions.ResourceAlreadyExistsException;
import jakarta.ws.rs.core.Response;
import java.util.Collections;
import lombok.RequiredArgsConstructor;
import org.keycloak.admin.client.CreatedResponseUtil;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.RoleRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.stereotype.Service;

/**
 * Servicio para la integración con Keycloak, encargado de crear usuarios y asignarles roles.
 */

@Service
@RequiredArgsConstructor
public class KeycloakIntegrationService {
    private final Keycloak keycloak;
    private static final String REALM = "unnoba";

    public UserRepresentation createUserInKeycloak(String username, String email, String password, String firstName, String lastName, String roleName) {
        UserRepresentation user = new UserRepresentation();
        user.setUsername(username);
        user.setEmail(email);
        user.setEnabled(true);

        if (firstName != null && !firstName.isBlank()) {
            user.setFirstName(firstName);
        }

        if (lastName != null && !lastName.isBlank()) {
            user.setLastName(lastName);
        }

        CredentialRepresentation credential = new CredentialRepresentation();
        credential.setType(CredentialRepresentation.PASSWORD);
        credential.setValue(password);
        credential.setTemporary(false);
        user.setCredentials(Collections.singletonList(credential));

        Response response = keycloak.realm(REALM).users().create(user);

        try {
            if (response.getStatus() == 409) {
                throw new ResourceAlreadyExistsException("User already exists in Keycloak.");
            }

            if (response.getStatus() != 201) {
                throw new RuntimeException("Failed to create user in Keycloak. Status: " + response.getStatus() + ".");
            }

            String createdId = CreatedResponseUtil.getCreatedId(response);
            
            if (roleName != null && !roleName.isBlank()) {
                RoleRepresentation role = keycloak.realm(REALM).roles().get(roleName).toRepresentation();
                keycloak.realm(REALM).users().get(createdId).roles().realmLevel().add(Collections.singletonList(role));
            }

            return keycloak.realm(REALM).users().get(createdId).toRepresentation();
        } finally {
            response.close();
        }
    }
}
