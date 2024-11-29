package br.com.hommei.dto;

import br.com.hommei.enuns.TipoPrestador;
import lombok.Data;

import java.util.List;

@Data
public class PrestadorResponseDTO extends UsuarioResponseDTO{
    private Integer idUsuario;
    private String cnpj;
    private TipoPrestador tipoPrestador;
    private String mensagemErro;
    private String nomeComercial;
    private String nomeCategoria;
    private List<String> nomeServico;
    private String fotoPerfil;

    public String getDocumento() {
        if (tipoPrestador == TipoPrestador.MICROEMPREENDEDOR) {
            return cnpj != null ? cnpj : "CNPJ não informado";
        } else if (tipoPrestador == TipoPrestador.AUTONOMO) {
            return getCpf() != null ? getCpf() : "CPF não informado";
        }
        return "Tipo de prestador inválido";
    }
}
