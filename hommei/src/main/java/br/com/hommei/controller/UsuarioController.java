package br.com.hommei.controller;

import br.com.hommei.dto.UsuarioInsercaoDTO;  // DTO de inserção de cliente
import br.com.hommei.dto.UsuarioResponseDTO;  // DTO de resposta para cliente
import br.com.hommei.dto.PrestadorInsercaoDTO;  // DTO de inserção de prestador
import br.com.hommei.dto.PrestadorResponseDTO;  // DTO de resposta para prestador
import br.com.hommei.entity.Usuario;
import br.com.hommei.mapper.ModelMapperCustom;
import br.com.hommei.repository.UsuarioRepository;
import br.com.hommei.service.UsuarioService;
import jakarta.persistence.EntityNotFoundException;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@Slf4j
@RequestMapping("/usuarios")
@CrossOrigin(origins = "*")
public class UsuarioController {

    @Autowired
    private UsuarioService service;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private ModelMapperCustom modelMapper;

    @PostMapping("/cliente")
    public ResponseEntity<UsuarioResponseDTO> cadastrarCliente(@Valid @RequestBody UsuarioInsercaoDTO usuarioDTO) {
        return service.cadastrarCliente(usuarioDTO);
    }

    @PostMapping("/prestador")
    public ResponseEntity<PrestadorResponseDTO> cadastrarPrestador(@RequestBody @Valid PrestadorInsercaoDTO prestadorDTO) {
        return service.cadastrarPrestador(prestadorDTO);
    }

    // Tratamento de erros de validação
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> handleValidationExceptions(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getFieldErrors().forEach(error ->
                errors.put(error.getField(), error.getDefaultMessage())
        );
        return ResponseEntity.badRequest().body(errors); // Retorna um mapa de campo -> mensagem de erro
    }

    @GetMapping("/{id}")
    public ResponseEntity<UsuarioResponseDTO> getUsuario(@PathVariable Integer id) {
        log.info("Buscando dados do usuário com ID: {}", id);
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));
        UsuarioResponseDTO usuarioResponse = modelMapper.map(usuario, UsuarioResponseDTO.class);
        return ResponseEntity.ok(usuarioResponse);
    }

    @GetMapping("/{id}/perfil")
    public ResponseEntity<UsuarioResponseDTO> buscarDadosPerfil(@PathVariable Integer id) {
        log.info("Solicitando dados do perfil para o usuário com ID: {}", id);
        return service.buscarDadosPerfil(id);
    }

    @PostMapping("/{id}/fotoPerfil")
    public ResponseEntity<UsuarioResponseDTO> uploadFotoPerfil(@PathVariable Integer id,
                                                               @RequestPart("file") MultipartFile file) {
        try {
            UsuarioResponseDTO usuarioResponse = service.uploadFotoPerfil(id, file);
            return ResponseEntity.ok(usuarioResponse);
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }



}
