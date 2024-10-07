package br.com.hommei.entity;

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


}
