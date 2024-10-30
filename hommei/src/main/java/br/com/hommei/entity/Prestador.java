package br.com.hommei.entity;

import br.com.hommei.enuns.TipoPrestador;
import com.fasterxml.jackson.annotation.JsonBackReference;
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
    @JsonBackReference
    private Categoria categoria;

    @Column(name = "TIPO_PRESTADOR")
    @Enumerated(EnumType.STRING)
    private TipoPrestador tipoPrestador;

    @ManyToMany
    @JoinTable(
            name = "PRESTADOR_SERV",
            joinColumns = @JoinColumn(name = "ID_USUARIO"),
            inverseJoinColumns = @JoinColumn(name = "ID_SERV")
    )
    private List<Servico> servico;

    @Override
    public String toString() {
        return "Prestador{" +
                "nomeComercial='" + nomeComercial + '\'' +
                ", tipoPrestador=" + tipoPrestador +
                ", categoriaId=" + (categoria != null ? categoria.getIdCategoria() : null) +
                '}';
    }
}
