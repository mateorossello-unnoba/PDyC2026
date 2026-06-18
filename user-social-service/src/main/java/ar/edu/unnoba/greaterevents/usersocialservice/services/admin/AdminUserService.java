package ar.edu.unnoba.greaterevents.usersocialservice.services.admin;

import ar.edu.unnoba.greaterevents.usersocialservice.dtos.admin.*;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public interface AdminUserService {
    // Método de creación
    AdminUserResponse createAdmin(AdminUserCreateRequest request);

    // Método de eliminación
    void deleteAdmin(String userId);

    // Métodos de consulta
    AdminUserResponse getAdminById(String userId);
    List<AdminUserResponse> getAdmins();
}
