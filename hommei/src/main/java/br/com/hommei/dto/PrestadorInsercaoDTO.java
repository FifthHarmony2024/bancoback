package br.com.hommei.dto;

import br.com.hommei.enuns.TipoPrestador;
import lombok.Data;

import java.util.List;

@Data
public class PrestadorInsercaoDTO extends UsuarioInsercaoDTO{
    private String nomeComercial;
    private String cnpj;
    private TipoPrestador tipoPrestador;
    private List<Integer> idCategoria;
    private Integer idServico;
}
