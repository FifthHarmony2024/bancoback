package br.com.hommei.dto;


import lombok.Data;

@Data
public class UsuarioResponseDTO {

    private String nome;
    private String sobrenome;
    private String email;
    private String telefone;
    private String estado;
    private String cidade;
}
