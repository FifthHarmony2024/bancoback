package br.com.hommei.entity;


import br.com.hommei.enuns.TipoDia;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;
import java.sql.Time;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;

@Data
@Entity
@Table(name = "AGENDA")
public class Agenda {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_AGENDA")
    private Integer idAgenda;

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO", nullable = false)
    private Usuario usuario;

    @Column(name = "TIPO_DIA")
    @Enumerated(EnumType.STRING)
    private TipoDia tipoDia;

    @Column(name = "HR_AGENDAMENTO")
    private LocalTime hrAgendamento;

    @Column(name = "DT_AGENDAMENTO")
    private Date dtAgendamento;

    @Column(name = "VL_ORC")
    private BigDecimal valorOrcamento;


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
