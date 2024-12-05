package br.com.hommei.service;


import br.com.hommei.dto.LoginRequestDTO;
import br.com.hommei.dto.LoginResponseDTO;
import br.com.hommei.dto.UsuarioAutenticadoDTO;
import br.com.hommei.security.JwtToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtToken token;


    public LoginResponseDTO autenticar(LoginRequestDTO request) {
        var usuario = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(request.getEmailLogin(),request.getSenha()));
        return LoginResponseDTO.builder().token(token.gerar((UserDetails) usuario.getPrincipal())).build();
    }


    private UsuarioAutenticadoDTO mockAutenticado() {
        return UsuarioAutenticadoDTO.builder().idUsuario(mockAutenticado().getIdUsuario())
                                              .nome(mockAutenticado().getNome())
                                              .emailLogin(mockAutenticado().getEmailLogin())
                                              .senha(mockAutenticado().getSenha())
                                              .roleEnum(mockAutenticado().getRoleEnum())

                .build();
    }


}
