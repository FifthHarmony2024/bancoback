package br.com.hommei.entity;

import br.com.hommei.enuns.TipoPrestador;
import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.validator.constraints.br.CNPJ;

import java.util.List;

@Data
@Entity
@Table(name = "PRESTADOR")
public class Prestador extends Usuario {

    @Column(name = "NOME_COMERCIAL")
    private String nomeComercial;

    @CNPJ
    @Column(name = "CNPJ")
    private String cnpj;

    @ManyToMany
    @JoinTable(
            name = "PRESTADOR_CATEGORIA",
            joinColumns = @JoinColumn(name = "ID_USUARIO"),
            inverseJoinColumns = @JoinColumn(name = "ID_CATEGORIA")
    )
    private List<Categoria> categorias;

    @ManyToOne
    @JoinColumn(name = "ID_SERVICO")
    private Servico servico;

    @Column(name = "TIPO_PRESTADOR")
    @Enumerated(EnumType.ORDINAL)
    private TipoPrestador tipoPrestador;
}
