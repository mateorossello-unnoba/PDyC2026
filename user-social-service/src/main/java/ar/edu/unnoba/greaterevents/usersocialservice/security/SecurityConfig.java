package ar.edu.unnoba.greaterevents.usersocialservice.security;

import ar.edu.unnoba.greaterevents.usersocialservice.utils.AuthenticationConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.web.SecurityFilterChain;

/**
 * Configuración de seguridad para el acceso a user-social-service.
 */

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        JwtAuthenticationConverter jwtAuthenticationConverter = new JwtAuthenticationConverter();
        jwtAuthenticationConverter.setJwtGrantedAuthoritiesConverter(new AuthenticationConverter());

        jwtAuthenticationConverter.setPrincipalClaimName("preferred_username");

        http
            .csrf(csrf -> csrf.disable()) // Deshabilitar CSRF para APIs REST.
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/internal/**").permitAll() // Permitir acceso a los endpoints de comunicación interna.
                .requestMatchers(HttpMethod.POST, "/auth/register").permitAll() // Permitir acceso público al endpoint de registro.
                .requestMatchers("/admin/users", "/admin/users/**").hasRole("admin") // Restringir acceso a endpoints de administración solo para usuarios con "admin" como rol.
                .anyRequest().authenticated() // Requerir autenticación para cualquier otra solicitud.
            )
            .oauth2ResourceServer(oauth2 -> oauth2.jwt(jwt -> jwt.jwtAuthenticationConverter(jwtAuthenticationConverter)));
        
        return http.build();
    }
}
