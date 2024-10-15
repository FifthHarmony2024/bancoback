package br.com.hommei.controller;

import br.com.hommei.dto.UsuarioInsercaoDTO;  // DTO de inserção de cliente
import br.com.hommei.dto.UsuarioResponseDTO;  // DTO de resposta para cliente
import br.com.hommei.dto.PrestadorInsercaoDTO;  // DTO de inserção de prestador
import br.com.hommei.dto.PrestadorResponseDTO;  // DTO de resposta para prestador
import br.com.hommei.service.UsuarioService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/usuarios")
@CrossOrigin(origins = "*")
public class UsuarioController {

    @Autowired
    private UsuarioService service;

    @PostMapping("/cliente")
    public ResponseEntity<UsuarioResponseDTO> cadastrarCliente(@Valid @RequestBody UsuarioInsercaoDTO usuarioDTO) {
        return service.cadastrarCliente(usuarioDTO);
    }

    @PostMapping("/prestador")
    public ResponseEntity<PrestadorResponseDTO> cadastrarPrestador(@RequestBody @Valid PrestadorInsercaoDTO prestadorDTO) {
        return service.cadastrarPrestador(prestadorDTO);
    }

}
