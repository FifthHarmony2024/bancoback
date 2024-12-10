package br.com.hommei.security;

import br.com.hommei.dto.UsuarioAutenticadoDTO;
import br.com.hommei.entity.Usuario;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Optional;

public class UsuarioAutenticadoHolder {


//    public static Optional<UsuarioAutenticadoDTO> get() {
//        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//        Object principal = authentication.getPrincipal();
//        if (principal instanceof UsuarioAutenticadoDTO) {
//            return Optional.of((UsuarioAutenticadoDTO) principal);
//        } else {
//            return Optional.empty();
//        }
//    }
//
//    public static Usuario getUsuario() {
//        return get().map(UsuarioAutenticadoDTO::toUsuario).orElse(null);
//    }

}
