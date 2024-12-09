package br.com.hommei.entity;


import br.com.hommei.enuns.TipoDia;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

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
    @Temporal(TemporalType.DATE)
    private Date diaServico;

    @OneToOne
    @JoinColumn(name = "ID_USUARIO")
    private Prestador prestador;

    @Column(name = "TIPO_DIA")
    @Enumerated(EnumType.STRING)
    private TipoDia tipoDia;

    @OneToMany(mappedBy = "agenda", cascade = CascadeType.ALL)
    private List<Agendamento> agendamentos;

}
