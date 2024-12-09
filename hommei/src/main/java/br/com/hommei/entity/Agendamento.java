package br.com.hommei.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;
import java.sql.Time;
import java.util.Date;

@Data
@Entity
@Table(name = "AGENDAMENTO")
public class Agendamento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_AGENDAMENTO")
    private Integer idAgendamento;

    @Column(name = "DT_AGENDAMENTO")
    private Date dtAgendamento;

    @Column(name = "HR_AGENDAMENTO")
    private Time hrAgendamento;

    @Column(name = "VL_ORC")
    private BigDecimal valorOrcamento;

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO", nullable = false)
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "ID_AGENDA", nullable = false)
    @JsonBackReference
    private Agenda agenda;

    @Column(name = "ENDERECO")
    private String endereco;

    @Column(name = "CIDADE")
    private String cidade;

    @Column(name = "BAIRRO")
    private String bairro;

    @Column(name = "NUM_RESIDENCIAL")
    private Integer numResidencial;

    @Column(name = "NOME_CLIENTE")
    private String nomeCliente;
}
