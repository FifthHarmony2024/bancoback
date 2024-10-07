package br.com.hommei.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "CONTRATO")
public class Contrato {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_CONTRATO")
    private Integer idContrato;

    @Column(name = "PER_TAXA")
    private Double porceTaxa;

    @ManyToOne
    @JoinColumn(name = "ID_PGTO", nullable = false)
    private Pagamento pagamento;

    @ManyToOne
    @JoinColumn(name = "ID_PRESTADOR", nullable = false)
    private Prestador prestador;
}
