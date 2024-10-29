package br.com.hommei.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.sql.Date;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "POSTAGEM")
public class Postagem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_POSTAGEM")
    private Integer idPostagem;

    @Column(name = "URL")
    private String url;

    @Column(name = "DESCRICAO_POST")
    private String descricaoPost;

    @Column(name = "RESOLUCAO")
    private String resolucao;

    @Column(name = "TIPO_ARQUIVO")
    private String tipoArquivo;

    @Column(name = "DT_POSTAGEM")
    private LocalDateTime dtPostagem;

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO", nullable = false)
    private Usuario usuario;


}
