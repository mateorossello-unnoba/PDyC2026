package ar.edu.unnoba.greaterevents.usersocialservice.repositories;

import ar.edu.unnoba.greaterevents.usersocialservice.models.user.*;
import java.util.Optional;
import java.util.Set;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/**
 * Repositorio para la entidad User.
 */

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsernameIgnoreCase(String username);
    Optional<User> findByEmail(String email);

    // Encontrar usuarios que marcaron un evento como favorito o que siguen a un artista relacionado con el evento.
    @Query("SELECT DISTINCT u FROM User u LEFT JOIN u.favoriteEvents favoriteEvent LEFT JOIN u.followedArtists followedArtist WHERE favoriteEvent = :eventId OR followedArtist IN :artistIds")
    Set<User> findUsersToNotifyAboutEvent(@Param("eventId") Long eventId, @Param("artistIds") Set<Long> artistIds);
}
