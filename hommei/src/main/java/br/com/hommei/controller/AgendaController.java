package br.com.hommei.controller;

import br.com.hommei.entity.Agenda;
import br.com.hommei.service.AgendaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/agendas")
@CrossOrigin(origins = "*")
public class AgendaController {

    @Autowired
    private AgendaService agendaService;

    // Endpoint para salvar uma agenda
    @PostMapping("/salvar")
    public ResponseEntity<Agenda> salvarAgenda(@RequestBody Agenda agenda) {
        try {
            Agenda agendaSalva = agendaService.salvarAgenda(agenda);
            return new ResponseEntity<>(agendaSalva, HttpStatus.CREATED);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }
    }

    // Endpoint para buscar uma agenda por ID
    @GetMapping("/{idAgenda}")
    public ResponseEntity<Agenda> buscarAgenda(@PathVariable Integer idAgenda) {
        Optional<Agenda> agendaOptional = agendaService.buscarPorId(idAgenda);
        if (agendaOptional.isPresent()) {
            return new ResponseEntity<>(agendaOptional.get(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(null, HttpStatus.NOT_FOUND);
        }
    }

    // Endpoint para marcar uma folga
    @PutMapping("/folga/{idUsuario}")
    public ResponseEntity<Agenda> marcarFolga(@PathVariable Integer idUsuario) {
        try {
            Agenda agenda = agendaService.marcarFolga(idUsuario);
            return new ResponseEntity<>(agenda, HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }
    }

    // Endpoint para marcar um dia de trabalho
    @PutMapping("/trabalho")
    public ResponseEntity<Agenda> marcarTrabalho(@RequestBody Agenda agenda) {
        try {
            Agenda agendaAtualizada = agendaService.marcarTrabalho(agenda);
            return new ResponseEntity<>(agendaAtualizada, HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }
    }
}
