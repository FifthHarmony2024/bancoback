package br.com.hommei.dto;

import br.com.hommei.enuns.RoleEnum;
import br.com.hommei.enuns.SexoOpcao;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;

@Data
public class UsuarioInsercaoDTO {

    private String nome;
    private String sobrenome;
    private String emailLogin;
    private String senha;
    private String telefone;
    private String cpf;
    private String endereco;
    private RoleEnum roleEnum;
    @NotNull(message = "Número residencial não pode ser nulo.")
    private Integer numResidencial;

    private String bairro;
    private String complementoResi;
    private String cep;
    private String cidade;
    private String estado;

    private LocalDate dataDeNascimento;

    private SexoOpcao sexoOpcao;
    private String confSenha;
}
