package br.com.hommei.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;
import java.sql.Time;
import java.time.LocalDateTime;
import java.util.Date;

@Data
@Entity
@Table(name = "AVALIACAO")
public class Avaliacao {

    @Id
    @Column(name = "ID_AVALIACAO")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idAvaliacao;

    @Column(name = "COMENTARIOS")
    private String comentarios;

    @Column(name = "NOTA")
    private Integer nota;

    @Column(name = "DT_AVALIACAO")
    private LocalDateTime dtAvaliacao;

    @ManyToOne
    @JoinColumn(name = "ID_PEDIDO")
    private Pedido idPedido;

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO")
    private Usuario id;

}
