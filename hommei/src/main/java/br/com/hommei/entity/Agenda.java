package br.com.hommei.entity;


import jakarta.persistence.*;
import lombok.Data;

import java.sql.Date;
import java.sql.Time;

@Data
@Entity
@Table(name = "AGENDA")
public class Agenda {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_AGENDA")
    private Integer idAgenda;

    @Column(name = "HR_DISPONIVEL")
    private Time hrDisponivel;

    @Column(name = "HR_INDISPONIVEL")
    private Time hrIndisponivel;

    @Column(name = "DIA_SERV")
    private Date diaServico;

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO")
    private Usuario id;


}
