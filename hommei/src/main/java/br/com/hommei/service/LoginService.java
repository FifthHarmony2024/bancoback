package br.com.hommei.service;


import br.com.hommei.dto.LoginRequestDTO;
import br.com.hommei.dto.LoginResponseDTO;
import br.com.hommei.dto.UsuarioAutenticadoDTO;
import br.com.hommei.enuns.RoleEnum;
import br.com.hommei.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class LoginService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;


    public LoginResponseDTO autenticar(LoginRequestDTO request) {
        return LoginResponseDTO.builder().token(UUID.randomUUID().toString()).build();
    }


    private UsuarioAutenticadoDTO mockAutenticado() {
        return UsuarioAutenticadoDTO.builder().idUsuario(mockAutenticado().getIdUsuario())
                                              .nome(mockAutenticado().getNome())
                                              .emailLogin(mockAutenticado().getEmailLogin())
                                              .senha(mockAutenticado().getSenha())
                                    .build();
    }


}
