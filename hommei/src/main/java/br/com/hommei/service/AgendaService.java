package br.com.hommei.service;

import br.com.hommei.entity.Agenda;
import br.com.hommei.entity.Usuario;
import br.com.hommei.enuns.TipoDia;
import br.com.hommei.repository.AgendaRepository;
import br.com.hommei.repository.PrestadorRepository;
import br.com.hommei.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;
@Service
public class AgendaService {

    @Autowired
    private AgendaRepository agendaRepository;

    @Autowired
    private UsuarioRepository usuarioRepository; // Repositório de Usuario

    public Agenda salvarAgenda(Agenda agenda) {
        // Garantir que o usuário está associado à agenda antes de salvar
        if (agenda.getUsuario() == null) {
            throw new RuntimeException("Usuário não associado à agenda.");
        }

        // Aqui, acessamos o Usuario associado à agenda
        Usuario usuario = agenda.getUsuario(); // Acesso direto à entidade Usuario

        // Faça algo com o Usuario se necessário, por exemplo, validando ou ajustando dados

        return agendaRepository.save(agenda);
    }

    // Buscar agenda por ID
    public Optional<Agenda> buscarPorId(Integer idAgenda) {
        return agendaRepository.findById(idAgenda);
    }

    public Agenda marcarFolga(Integer idUsuario) {
        Agenda agenda = buscarOuCriarAgenda(idUsuario);

        // Marcar como folga
        agenda.setTipoDia(TipoDia.FOLGA);

        // Definir os outros campos como null para garantir que eles não carreguem dados antigos
        agenda.setValorOrcamento(null);
        agenda.setEndereco(null);
        agenda.setCidade(null);
        agenda.setBairro(null);
        agenda.setNumResidencial(null);
        agenda.setNomeCliente(null);
        agenda.setHrAgendamento(null);

        return agendaRepository.save(agenda);
    }

    public Agenda marcarTrabalho(Agenda agenda) {
        // Buscar ou criar a agenda do usuário
        Agenda agendaExistente = buscarOuCriarAgenda(agenda.getUsuario().getIdUsuario());

        // Verifica se o usuário está associado corretamente
        if (agendaExistente.getUsuario() == null) {
            throw new RuntimeException("Usuário não associado à agenda.");
        }

        // Atualizar os campos da agenda com os dados enviados na requisição
        agendaExistente.setTipoDia(TipoDia.TRABALHO);
        agendaExistente.setValorOrcamento(agenda.getValorOrcamento());
        agendaExistente.setEndereco(agenda.getEndereco());
        agendaExistente.setCidade(agenda.getCidade());
        agendaExistente.setBairro(agenda.getBairro());
        agendaExistente.setNumResidencial(agenda.getNumResidencial());
        agendaExistente.setNomeCliente(agenda.getNomeCliente());
        agendaExistente.setHrAgendamento(agenda.getHrAgendamento());
        agendaExistente.setDtAgendamento(agenda.getDtAgendamento());

        // Salvar as alterações na agenda
        return agendaRepository.save(agendaExistente);
    }

    private Agenda buscarOuCriarAgenda(Integer idUsuario) {
        // Verifica se já existe uma agenda para o usuário
        Optional<Agenda> agendaOptional = agendaRepository.findByUsuario_IdUsuario(idUsuario);

        if (agendaOptional.isPresent()) {
            return agendaOptional.get();
        }

        // Caso não tenha uma agenda, cria uma nova
        Agenda novaAgenda = new Agenda();

        // Buscar o usuário pelo idUsuario
        var usuario = usuarioRepository.findById(idUsuario)
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));

        // Atribuindo o usuário à nova agenda
        novaAgenda.setUsuario(usuario);

        // Se o usuário não estiver sendo associado corretamente, pode haver um problema
        if (novaAgenda.getUsuario() == null) {
            throw new RuntimeException("Usuário não foi atribuído corretamente à agenda.");
        }

        // Salvar a nova agenda
        return agendaRepository.save(novaAgenda);
    }
}
