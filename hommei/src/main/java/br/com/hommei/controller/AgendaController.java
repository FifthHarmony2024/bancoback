package br.com.hommei.controller;

import br.com.hommei.entity.Agenda;
import br.com.hommei.entity.Agendamento;
import br.com.hommei.service.AgendaService;
import br.com.hommei.service.AgendamentoService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/agendas")
@CrossOrigin(origins = "*")
public class AgendaController {

    @Autowired
    private AgendaService agendaService;

    @Autowired
    private AgendamentoService agendamentoService;

    @PostMapping("/salvar")
    public ResponseEntity<Agenda> salvarAgenda(@RequestBody Agenda agenda) {
        try {
            Agenda agendaSalva = agendaService.salvarAgenda(agenda);
            return ResponseEntity.ok(agendaSalva);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

    @GetMapping("/agendamentos/{idUsuario}")
    public ResponseEntity<List<Agendamento>> listarAgendamentosPorPrestador(@PathVariable Integer idUsuario) {
        try {
            List<Agendamento> agendamentos = agendamentoService.listarAgendamentosPorPrestador(idUsuario);
            return ResponseEntity.ok(agendamentos);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping("/agendar")
    public ResponseEntity<Agendamento> agendar(@RequestBody Agendamento agendamento) {
        try {
            Agendamento agendamentoCriado = agendaService.criarAgendamento(agendamento);
            return ResponseEntity.status(HttpStatus.CREATED).body(agendamentoCriado);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
    }

    @GetMapping("/prestador/{idUsuario}")
    public ResponseEntity<Agenda> buscarAgendaPorPrestador(@PathVariable Integer idUsuario) {
        try {
            Agenda agenda = agendaService.buscarAgendaPorPrestador(idUsuario);
            return ResponseEntity.ok(agenda);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/deletar/{idAgenda}")
    public ResponseEntity<String> deletarAgenda(@PathVariable Integer idAgenda) {
        boolean agendaDeletada = agendaService.deletarAgenda(idAgenda);
        if (agendaDeletada) {
            return ResponseEntity.ok("Agenda deletada com sucesso.");
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
