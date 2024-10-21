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

    @ManyToOne
    @JoinColumn(name = "ID_CATEGORIA", nullable = false)
    private Categoria categoria;

    @ManyToMany
    @JoinTable(
            name = "PRESTADOR_CATEGORIA",
            joinColumns = @JoinColumn(name = "ID_USUARIO"),
            inverseJoinColumns = @JoinColumn(name = "ID_CATEGORIA")
    )
    private List<Categoria> categorias;


    @ManyToOne
    @JoinColumn(name = "ID_SERV")
    private Servico servico;

    @ManyToMany
    @JoinTable(
            name = "PRESTADOR_SERV ",
            joinColumns = @JoinColumn(name = "ID_USUARIO"),
            inverseJoinColumns = @JoinColumn(name = "ID_SERV")
    )
    private List<Servico> servicos;


    @Column(name = "TIPO_PRESTADOR")
    @Enumerated(EnumType.ORDINAL)
    private TipoPrestador tipoPrestador;
}
