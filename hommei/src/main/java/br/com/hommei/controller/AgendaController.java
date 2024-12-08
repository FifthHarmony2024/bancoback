package br.com.hommei.controller;

import br.com.hommei.dto.MarcacaoFolgaDTO;
import br.com.hommei.service.AgendaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/agenda")
public class AgendaController {

    @Autowired
    private AgendaService agendaService;

    @PostMapping("/folga")
    public ResponseEntity<String> marcarFolga(@RequestBody MarcacaoFolgaDTO marcacaoFolgaDTO) {
        agendaService.marcarFolga(marcacaoFolgaDTO);
        return ResponseEntity.ok("Folga marcada com sucesso!");
    }
}
