package ar.edu.unnoba.greaterevents.usersocialservice.repositories;

import ar.edu.unnoba.greaterevents.usersocialservice.models.user.*;
import java.util.Optional;
import java.util.Set;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsernameIgnoreCase(String username);
    Optional<User> findByEmail(String email);

    // Método para encontrar usuarios que marcaron un evento como favorito
    @Query("SELECT DISTINCT u FROM User u LEFT JOIN u.favoriteEvents fe LEFT JOIN u.followedArtists fa WHERE fe = :eventId OR fa IN :artistIds")
    Set<User> findUsersToNotifyAboutEvent(@Param("eventId") Long eventId, @Param("artistIds") Set<Long> artistIds);
}
