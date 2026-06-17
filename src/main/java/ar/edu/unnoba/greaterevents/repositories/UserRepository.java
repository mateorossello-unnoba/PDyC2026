package ar.edu.unnoba.greaterevents.repositories;

import ar.edu.unnoba.greaterevents.models.user.User;
import java.util.Optional;
import java.util.Set;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsernameIgnoreCase(String username);
    Optional<User> findByEmail(String email);

    // Método para encontrar usuarios que marcaron un evento como favorito
    @Query("SELECT DISTINCT u FROM User u LEFT JOIN u.favoriteEvents fe LEFT JOIN u.followedArtists fa WHERE fe.id = :eventId OR fa IN (SELECT a FROM Artist a JOIN a.events e WHERE e.id = :eventId)")
    Set<User> findUsersToNotifyAboutEvent(Long eventId);
}
