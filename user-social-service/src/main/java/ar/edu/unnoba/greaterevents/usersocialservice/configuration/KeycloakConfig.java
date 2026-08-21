package ar.edu.unnoba.greaterevents.usersocialservice.configuration;

import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.KeycloakBuilder;
import org.keycloak.OAuth2Constants;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Configuración de Keycloak para la autenticación de user-social-service.
 */

@Configuration
public class KeycloakConfig {
    @Value("${keycloak-admin.server-url}")
    private String serverUrl;

    @Value("${keycloak-admin.realm}")
    private String realm;

    @Value("${keycloak-admin.client-id}")
    private String clientId;

    @Value("${keycloak-admin.client-secret}")
    private String clientSecret;

    @Bean
    Keycloak keycloak() {
        // Configura el cliente de Keycloak para autenticarse con las credenciales del cliente.
        return KeycloakBuilder.builder()
            .serverUrl(serverUrl)
            .realm(realm)
            .grantType(OAuth2Constants.CLIENT_CREDENTIALS)
            .clientId(clientId)
            .clientSecret(clientSecret)
            .build();
    }
}
