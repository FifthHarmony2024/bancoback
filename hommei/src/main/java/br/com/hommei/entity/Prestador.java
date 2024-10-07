package br.com.hommei.entity;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.validator.constraints.br.CNPJ;

import java.util.Set;

@Data
@Entity
@Table(name = "PRESTADOR")
public class Prestador {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_PRESTADOR")
    private Integer idPrestador;

    @Column(name = "NOME_COMERCIAL")
    private String nomeComercial;

    @CNPJ
    @Column(name = "CNPJ")
    private String cnpj;

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO")
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "ID_CATEGORIA")
    private Categoria categoria;

    @ManyToOne
    @JoinColumn(name = "ID_SERVICO")
    private Servico servico;

    @ManyToMany
    @JoinTable(
            name = "PRESTADOR_SERV",
            joinColumns = @JoinColumn(name = "ID_PRESTADOR"),
            inverseJoinColumns = @JoinColumn(name = "ID_SERV")
    )
    private Set<Servico> servicos;

}
