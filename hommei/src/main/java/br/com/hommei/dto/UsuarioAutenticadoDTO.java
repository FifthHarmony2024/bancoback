package br.com.hommei.dto;

import br.com.hommei.entity.Usuario;
import br.com.hommei.enuns.RoleEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UsuarioAutenticadoDTO {

    private Integer idUsuario;
    private String nome;
    private String emailLogin;
    private String senha;
    private RoleEnum role;

    public Usuario toUsuario() {
        Usuario usuario = new Usuario();
        usuario.setIdUsuario(idUsuario);
        return usuario;
    }

}
