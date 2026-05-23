package ar.edu.unnoba.greaterevents.services;

import ar.edu.unnoba.greaterevents.exceptions.ResourceAlreadyExistsException;
import jakarta.ws.rs.core.Response;
import java.util.Collections;
import lombok.RequiredArgsConstructor;
import org.keycloak.admin.client.CreatedResponseUtil;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.RoleRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class KeycloakIntegrationService {
    private final Keycloak keycloak;
    private final String realm = "unnoba";

    public UserRepresentation createUserInKeycloak(String username, String email, String password, String firstName, String lastName, String roleName) {
        UserRepresentation user = new UserRepresentation();
        user.setUsername(username);
        user.setEmail(email);
        user.setEnabled(true);

        if (firstName != null && !firstName.isEmpty()) {
            user.setFirstName(firstName);
        }

        if (lastName != null && !lastName.isEmpty()) {
            user.setLastName(lastName);
        }

        CredentialRepresentation credential = new CredentialRepresentation();
        credential.setType(CredentialRepresentation.PASSWORD);
        credential.setValue(password);
        credential.setTemporary(false);
        user.setCredentials(Collections.singletonList(credential));

        Response response = keycloak.realm(realm).users().create(user);

        try {
            if (response.getStatus() == 409) {
                throw new ResourceAlreadyExistsException("User with the same username already exists");
            }

            if (response.getStatus() != 201) {
                throw new RuntimeException("Failed to create user in Keycloak");
            }

            String createdId = CreatedResponseUtil.getCreatedId(response);
            
            if (roleName != null && !roleName.isEmpty()) {
                RoleRepresentation role = keycloak.realm(realm).roles().get(roleName).toRepresentation();
                keycloak.realm(realm).users().get(createdId).roles().realmLevel().add(Collections.singletonList(role));
            }

            return keycloak.realm(realm).users().get(createdId).toRepresentation();
        } finally {
            response.close();
        }
    }
}
