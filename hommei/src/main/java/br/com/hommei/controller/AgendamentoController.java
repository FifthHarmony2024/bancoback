package br.com.hommei.controller;

import br.com.hommei.entity.Agendamento;
import br.com.hommei.service.AgendamentoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/agendamentos")
public class AgendamentoController {

    @Autowired
    private AgendamentoService agendamentoService;

    @PostMapping("/salvar")
    public ResponseEntity<Agendamento> salvarAgendamento(@RequestBody Agendamento agendamento) {
        try {
            Agendamento agendamentoSalvo = agendamentoService.salvarAgendamento(agendamento);
            return ResponseEntity.ok(agendamentoSalvo);
        } catch (IllegalArgumentException e) {

            return ResponseEntity.badRequest().body(null);
        }
    }
}
