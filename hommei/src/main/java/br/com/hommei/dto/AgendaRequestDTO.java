package br.com.hommei.dto;

import br.com.hommei.enuns.TipoDia;
import lombok.Data;

import java.sql.Date;
import java.sql.Time;

@Data
public class AgendaRequestDTO {

    private Integer idAgenda;

    private Time hrDisponivel;

    private Time hrIndisponivel;

    private Date diaServico;

    private Integer idUsuario;

    private TipoDia tipoDia;
}
