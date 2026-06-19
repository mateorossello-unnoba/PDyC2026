package ar.edu.unnoba.greaterevents.catalogeventservice.security;

import ar.edu.unnoba.greaterevents.catalogeventservice.utils.AuthenticationConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        JwtAuthenticationConverter jwtAuthenticationConverter = new JwtAuthenticationConverter();
        jwtAuthenticationConverter.setJwtGrantedAuthoritiesConverter(new AuthenticationConverter());

        jwtAuthenticationConverter.setPrincipalClaimName("preferred_username");

        http
            .csrf(csrf -> csrf.disable()) // Deshabilitar CSRF para APIs REST
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/internal/**").permitAll() // Permitir acceso a los endpoints de comunicación interna
                .requestMatchers(HttpMethod.GET, "/artists", "/artists/**").permitAll() // Permitir acceso público a los endpoints de artistas
                .requestMatchers(HttpMethod.GET, "/events", "/events/**").permitAll() // Permitir acceso público a los endpoints de eventos
                .requestMatchers("/admin/**").hasRole("admin") // Restringir acceso a endpoints de administración solo para usuarios con rol "admin"
                .anyRequest().authenticated()
            )
            .oauth2ResourceServer(oauth2 -> oauth2.jwt(jwt -> jwt.jwtAuthenticationConverter(jwtAuthenticationConverter)));
        
        return http.build();
    }
}
