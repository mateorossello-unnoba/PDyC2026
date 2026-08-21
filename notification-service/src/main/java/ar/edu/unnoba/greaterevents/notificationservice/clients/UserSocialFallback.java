package ar.edu.unnoba.greaterevents.notificationservice.clients;

import ar.edu.unnoba.greaterevents.notificationservice.dtos.user.*;
import java.util.Collections;
import java.util.Set;
import org.springframework.stereotype.Component;

@Component
public class UserSocialFallback implements UserSocialClient {
    //TODO: Puede ser reemplazado por un Fallback Factory para devolver una respuesta más detallada en caso de error.

    @Override
    public UserListResponse getUserByUsername(String username) {
        return null;
    }

    @Override
    public Set<UserListResponse> getInterestedUsers(Long eventId, Set<Long> artistIds) {
        return Collections.emptySet();
    } 
}
