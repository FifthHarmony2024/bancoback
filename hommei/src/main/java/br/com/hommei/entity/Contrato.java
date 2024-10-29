package br.com.hommei.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "CONTRATO")
public class Contrato {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_CONTRATO")
    private Integer idContrato;

    @Column(name = "PER_TAXA", nullable = false)
    private Double porceTaxa;

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO", nullable = false)
    private Usuario usuario;

    @Column(name = "DATA_ACEITE", nullable = false)
    private LocalDateTime dataAceite;
}

