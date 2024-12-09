package br.com.hommei.service;

import br.com.hommei.entity.Agenda;
import br.com.hommei.entity.Agendamento;
import br.com.hommei.entity.Prestador;
import br.com.hommei.entity.Usuario;
import br.com.hommei.repository.AgendaRepository;
import br.com.hommei.repository.AgendamentoRepository;
import br.com.hommei.repository.PrestadorRepository;
import br.com.hommei.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AgendaService {

    @Autowired
    private AgendaRepository agendaRepository;

    @Autowired
    private PrestadorRepository prestadorRepository;

    @Autowired
    private AgendamentoRepository agendamentoRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    public Agenda salvarAgenda(Agenda agenda) {

        Prestador prestador = prestadorRepository.findById(agenda.getPrestador().getIdUsuario())
                .orElseThrow(() -> new IllegalArgumentException("Prestador não encontrado"));

        agendaRepository.findByPrestador(prestador).ifPresent(a -> agenda.setIdAgenda(a.getIdAgenda()));

        agenda.setPrestador(prestador);
        return agendaRepository.save(agenda);
    }


    public Agenda buscarAgendaPorPrestador(Integer idUsuario) {
        Prestador prestador = prestadorRepository.findById(idUsuario)
                .orElseThrow(() -> new IllegalArgumentException("Prestador não encontrado"));
        return agendaRepository.findByPrestador(prestador)
                .orElseThrow(() -> new IllegalArgumentException("Agenda não encontrada"));
    }


    public Agendamento criarAgendamento(Agendamento agendamento) {
        Agenda agenda = agendaRepository.findById(agendamento.getAgenda().getIdAgenda())
                .orElseThrow(() -> new IllegalArgumentException("Agenda não encontrada"));

        Usuario usuario = usuarioRepository.findById(agendamento.getUsuario().getIdUsuario())
                .orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado"));


        agendamento.setAgenda(agenda);
        agendamento.setUsuario(usuario);

        return agendamentoRepository.save(agendamento);
    }
    public boolean deletarAgenda(Integer idAgenda) {
        if (agendaRepository.existsById(idAgenda)) {
            agendaRepository.deleteById(idAgenda);
            return true;
        }
        return false;
    }


}
