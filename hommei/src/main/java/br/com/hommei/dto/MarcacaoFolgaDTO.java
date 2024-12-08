package br.com.hommei.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MarcacaoFolgaDTO {
    private Integer idUsuario; // ID do prestador
    private Date diaServico;  // Data específica para marcar como folga
}