package br.com.hommei.dto;

import br.com.hommei.enuns.TipoPrestador;
import lombok.Data;

@Data
public class PrestadorResponseDTO {
    private String nome;
    private String emailLogin;
    private String cpf;
    private String cnpj;
    private TipoPrestador tipoPrestador;
}
