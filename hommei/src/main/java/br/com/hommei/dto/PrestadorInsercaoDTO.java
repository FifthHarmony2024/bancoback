package br.com.hommei.dto;

import br.com.hommei.enuns.RoleEnum;
import br.com.hommei.enuns.TipoPrestador;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;

@Data
public class PrestadorInsercaoDTO extends UsuarioInsercaoDTO{
    private String nomeComercial;
    private String cnpj;
    private TipoPrestador tipoPrestador;
    @NotNull(message = "A Categoria não pode ser nulo.")
    private Integer idCategoria;
    private List<Integer> idServico;
    private String nomeCategoria;
    private String nomeServico;
    private String fotoPerfil;
    private RoleEnum roleEnum;
    public String getDocumento() {
        if (tipoPrestador == TipoPrestador.MICROEMPREENDEDOR) {
            return cnpj != null ? cnpj : "CNPJ não informado";
        } else if (tipoPrestador == TipoPrestador.AUTONOMO) {
            return getCpf() != null ? getCpf() : "CPF não informado";
        }
        return "Tipo de prestador inválido";
    }
}
