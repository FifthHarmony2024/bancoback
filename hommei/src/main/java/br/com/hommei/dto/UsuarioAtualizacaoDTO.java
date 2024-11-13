package br.com.hommei.dto;

import lombok.Data;


@Data
public class UsuarioAtualizacaoDTO {

    private String nome;
    private String sobrenome;
    private String senha;
    private String emailLogin;
    private String telefone;
    private String endereco;
    private Integer numResidencial;
    private String bairro;
    private String complementoResi;
    private String cep;
    private String cidade;
    private String estado;
}
