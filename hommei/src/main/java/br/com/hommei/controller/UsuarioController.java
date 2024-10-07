package br.com.hommei.controller;


import br.com.hommei.dto.UsuarioResponseDTO;
import br.com.hommei.entity.Prestador;
import br.com.hommei.entity.Usuario;
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
    public ResponseEntity<Usuario> cadastrarCliente(@RequestBody @Valid Usuario usuario) {
        return service.cadastrarCliente(usuario);
    }

    @PostMapping("/prestador")
    public ResponseEntity<Prestador> cadastrarPrestador(@RequestBody @Valid Prestador prestador) {
        return service.cadastrarPrestador(prestador);
    }

    @GetMapping
    public List<UsuarioResponseDTO> listar(){return service.listar();}


}
