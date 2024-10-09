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

    // Endpoint para cadastro de cliente
    @PostMapping("/cliente")
    public ResponseEntity<UsuarioResponseDTO> cadastrarCliente(@RequestBody @Valid UsuarioInsercaoDTO usuarioDTO) {
        // Chama o serviço que cuida da lógica de cadastro do cliente
        return service.cadastrarCliente(usuarioDTO);
    }

    // Endpoint para cadastro de prestador
    @PostMapping("/prestador")
    public ResponseEntity<PrestadorResponseDTO> cadastrarPrestador(@RequestBody @Valid PrestadorInsercaoDTO prestadorDTO) {
        // Chama o serviço que cuida da lógica de cadastro do prestador
        return service.cadastrarPrestador(prestadorDTO);
    }

}
