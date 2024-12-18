package br.com.hommei.controller;

import br.com.hommei.dto.*;
import br.com.hommei.entity.Usuario;
import br.com.hommei.mapper.ModelMapperCustom;
import br.com.hommei.repository.UsuarioRepository;
import br.com.hommei.service.UsuarioService;
import jakarta.persistence.EntityNotFoundException;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> handleValidationExceptions(MethodArgumentNotValidException ex) {
        System.out.println("Interceptando erro de validação...");
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getFieldErrors().forEach(error ->
                errors.put(error.getField(), error.getDefaultMessage())
        );
        return ResponseEntity.badRequest().body(errors);
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

    @GetMapping("/prestadores/buscar-termo")
    public ResponseEntity<?> buscarPrestadoresPorNomeCategoriaOuServico(@RequestParam String termo) {
        log.info("Recebida requisição de busca com termo: {}", termo);
        return service.buscarPrestadoresPorNomeComercialOuCategoriaOuServico(termo);
    }

    @GetMapping("/{id}/perfilPrestador")
    public ResponseEntity<?> buscarDadosPerfilPrestador(@PathVariable Integer id) {
        log.info("Recebendo solicitação para buscar o perfil do prestador com ID: {}", id);

        ResponseEntity<?> response = service.buscarDadosPerfilPrestador(id);

        log.info("Retornando dados do perfil do prestador com ID: {}", id);
        return response;
    }


    @PostMapping("/{idUsuario}/foto-perfil")
    public ResponseEntity<String> adicionarFotoPerfil(
            @PathVariable Integer idUsuario,
            @RequestParam("file") MultipartFile file) {
        return service.adicionarFotoPerfil(idUsuario, file);
    }

    @GetMapping("/{idUsuario}/foto-adicionada")
    public ResponseEntity<String> getFotoPerfil(@PathVariable Integer idUsuario) {
        return service.getFotoPerfilByUsuarioId(idUsuario);
    }

}
