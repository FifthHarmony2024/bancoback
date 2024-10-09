package br.com.hommei.dto;

import br.com.hommei.enuns.RoleEnum;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class UsuarioInsercaoDTO {

    private String nome;
    private String emailLogin;
    private String senha;
    private RoleEnum role;

}
