package br.com.hommei.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Data
@Entity
@Table(name = "SERVICO")
public class Servico {

    @Id
    @Column(name = "ID_SERV")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idServico;

    @Column(name = "NOME_SERVICO")
    private String nomeServico;

    @Column(name = "DESCRICAO_SERVICO")
    private String descricaoServico;

    @ManyToOne
    @JoinColumn(name = "ID_CATEGORIA")
    private Categoria idCate;

    @ManyToMany(mappedBy = "servico")
    private List<Prestador> prestadores;


}
