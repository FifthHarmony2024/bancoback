package br.com.hommei.service;

import br.com.hommei.entity.Agenda;
import br.com.hommei.entity.Agendamento;
import br.com.hommei.entity.Usuario;
import br.com.hommei.repository.AgendamentoRepository;
import br.com.hommei.repository.AgendaRepository;
import br.com.hommei.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Time;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class AgendamentoService {

    @Autowired
    private AgendamentoRepository agendamentoRepository;

    @Autowired
    private AgendaRepository agendaRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    // Método para salvar agendamento
    public Agendamento salvarAgendamento(Agendamento agendamento) {
        Usuario usuario = usuarioRepository.findById(agendamento.getUsuario().getIdUsuario())
                .orElseThrow(() -> new IllegalArgumentException("Prestador não encontrado"));

        Agenda agenda = agendaRepository.findById(agendamento.getAgenda().getIdAgenda())
                .orElseThrow(() -> new IllegalArgumentException("Agenda não encontrada"));

        if (!isHoraDisponivel(agenda, agendamento.getHrAgendamento())) {
            throw new IllegalArgumentException("Horário indisponível para este prestador");
        }

        if (!isSameDay(agenda.getDiaServico(), agendamento.getDtAgendamento())) {
            throw new IllegalArgumentException("A data do agendamento não corresponde ao dia disponível da agenda");
        }

        agendamento.setUsuario(usuario);
        agendamento.setAgenda(agenda);

        agenda.getAgendamentos().add(agendamento);

        Agendamento agendamentoSalvo = agendamentoRepository.save(agendamento);

        agendaRepository.save(agenda);

        return agendamentoSalvo;
    }

    // Método para listar todos os agendamentos de um prestador (idUsuario)
    public List<Agendamento> listarAgendamentosPorPrestador(Integer idUsuario) {
        Usuario usuario = usuarioRepository.findById(idUsuario)
                .orElseThrow(() -> new IllegalArgumentException("Prestador não encontrado"));

        // Retorna todos os agendamentos relacionados ao prestador
        return agendamentoRepository.findByUsuario(usuario);
    }

    // Método para verificar se a hora do agendamento está disponível
    private boolean isHoraDisponivel(Agenda agenda, Time horaAgendamento) {
        return horaAgendamento.after(agenda.getHrDisponivel()) && horaAgendamento.before(agenda.getHrIndisponivel());
    }

    // Método para verificar se a data do agendamento é o mesmo dia da agenda
    private boolean isSameDay(Date date1, Date date2) {
        Calendar cal1 = Calendar.getInstance();
        Calendar cal2 = Calendar.getInstance();

        cal1.setTime(date1);
        cal2.setTime(date2);

        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
                cal1.get(Calendar.MONTH) == cal2.get(Calendar.MONTH) &&
                cal1.get(Calendar.DAY_OF_MONTH) == cal2.get(Calendar.DAY_OF_MONTH);
    }
}
