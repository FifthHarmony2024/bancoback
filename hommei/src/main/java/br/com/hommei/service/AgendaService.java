package br.com.hommei.service;

import br.com.hommei.dto.MarcacaoFolgaDTO;
import br.com.hommei.entity.Agenda;
import br.com.hommei.entity.Usuario;
import br.com.hommei.enuns.TipoDia;
import br.com.hommei.repository.AgendaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.Optional;

@Service
public class AgendaService {

    @Autowired
    private AgendaRepository agendaRepository;

    public void marcarFolga(MarcacaoFolgaDTO marcacaoFolgaDTO) {
        // Converte a data para java.sql.Date
        Date diaServicoSql = new Date(marcacaoFolgaDTO.getDiaServico().getTime());

        // Verifica se a agenda já existe para o usuário e a data especificada
        Optional<Agenda> agendaOptional = agendaRepository.findByUsuarioIdUsuarioAndDiaServico(
                marcacaoFolgaDTO.getIdUsuario(),
                diaServicoSql
        );

        if (agendaOptional.isPresent()) {
            // Se a agenda já existir, apenas atualiza o tipo de dia para FOLGA
            Agenda agenda = agendaOptional.get();
            agenda.setTipoDia(TipoDia.FOLGA);  // Marca como folga
            agendaRepository.save(agenda);
        } else {
            // Se a agenda não existir, cria uma nova entrada com tipo de dia FOLGA
            Agenda novaAgenda = new Agenda();
            novaAgenda.setDiaServico(diaServicoSql);
            novaAgenda.setTipoDia(TipoDia.FOLGA);  // Marca como folga

            // Define o usuário com o ID fornecido
            Usuario usuario = new Usuario();
            usuario.setIdUsuario(marcacaoFolgaDTO.getIdUsuario());
            novaAgenda.setUsuario(usuario);

            // Não atribui valores para HR_DISPONIVEL e HR_INDISPONIVEL
            novaAgenda.setHrDisponivel(null); // Não atribui horário disponível
            novaAgenda.setHrIndisponivel(null); // Não atribui horário indisponível

            agendaRepository.save(novaAgenda);  // Salva a nova agenda
        }
    }
}
