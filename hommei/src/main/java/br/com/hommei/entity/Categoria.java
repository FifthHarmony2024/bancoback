package br.com.hommei.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Data
@Entity
@Table(name = "CATEGORIA")
public class Categoria {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_CATEGORIA")
    private Integer idCategoria;

    @Column(name = "NOME_CATEGORIA")
    private String nomeCategoria;

    @OneToMany(mappedBy = "categoria")
    private List<Prestador> prestadores;
}
