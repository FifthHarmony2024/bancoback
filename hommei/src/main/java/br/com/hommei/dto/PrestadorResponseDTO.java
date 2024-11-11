package br.com.hommei.dto;

import br.com.hommei.enuns.TipoPrestador;
import lombok.Data;

@Data
public class PrestadorResponseDTO{
    private String cnpj;
    private TipoPrestador tipoPrestador;
    private String mensagemErro;
}
