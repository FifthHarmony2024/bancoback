package br.com.hommei.dto;

import br.com.hommei.enuns.RoleEnum;
import br.com.hommei.enuns.SexoOpcao;
import lombok.Data;
import org.hibernate.validator.constraints.br.CPF;

import java.time.LocalDate;

@Data
public class UsuarioResponseDTO {

        private String nome;
        private String sobrenome;
        private String senha;
        private String emailLogin;
        private String telefone;

        @CPF(message = "CPF inválido")
        private String cpf;
        private String endereco;
        private RoleEnum roleEnum;
        private Integer numResidencial;
        private String bairro;
        private String complementoResi;
        private String cep;
        private String cidade;
        private String estado;

        private LocalDate dataDeNascimento;

        private SexoOpcao sexoOpcao;
        private String confSenha;
        private String fotoPerfil;
}
