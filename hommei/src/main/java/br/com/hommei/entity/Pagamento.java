package br.com.hommei.entity;

import br.com.hommei.enuns.FormaPgto;
import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;
import java.sql.Date;

@Data
@Entity
@Table(name = "PAGAMENTO")
public class Pagamento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_PGT")
    private Integer idPagamento;

    @Column(name = "VL_TAXA")
    private BigDecimal valorTaxa;

    @Column(name = "FORMA_PGT")
    @Enumerated(EnumType.ORDINAL)
    private FormaPgto formaPgto;

    @Column(name = "DATA_PG")
    private Date dataPagamento;

    @Column(name = "VALOR")
    private BigDecimal valor;

    @ManyToOne
    @JoinColumn(name = "ID_CONTRATO")
    private Contrato id;

}
