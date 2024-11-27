package br.com.hommei.controller;

import br.com.hommei.entity.Postagem;
import br.com.hommei.service.FileStorageService;
import br.com.hommei.service.PostagemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/postagens")
@CrossOrigin(origins = "*")
public class PostagemController {

    @Autowired
    private FileStorageService fileStorageService;

    @Autowired
    private PostagemService postagemService;

    // Endpoint para upload e criação de uma nova postagem
    @PostMapping("/upload")
    public ResponseEntity<String> uploadPostagem(
            @RequestParam("file") MultipartFile file,
            @RequestParam("descricao") String descricao,
            @RequestParam("usuarioId") Integer usuarioId) {
        try {
            // Salva o arquivo e obtém o caminho/URL
            String url = fileStorageService.saveFile(file);

            // Cria a nova postagem
            Postagem postagem = new Postagem();
            postagem.setUrl(url);
            postagem.setDescricaoPost(descricao);
            postagem.setDtPostagem(LocalDateTime.now());
            postagem.setTipoArquivo(file.getContentType());
            postagem.setResolucao(file.getOriginalFilename());
            postagem.setUsuario(postagemService.getUsuarioById(usuarioId));

            // Salva no banco de dados
            postagemService.savePostagem(postagem);

            return ResponseEntity.ok("Upload realizado com sucesso. URL: " + url);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Erro ao realizar upload: " + e.getMessage());
        }
    }

    // Endpoint para buscar todas as postagens
    @GetMapping
    public ResponseEntity<List<Postagem>> listarPostagens() {
        List<Postagem> postagens = postagemService.getAllPostagens();
        return ResponseEntity.ok(postagens);
    }

    // Endpoint para buscar uma postagem específica por ID
    @GetMapping("/{id}")
    public ResponseEntity<Postagem> buscarPostagemPorId(@PathVariable Integer id) {
        try {
            Postagem postagem = postagemService.getPostagemById(id);
            return ResponseEntity.ok(postagem);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    // Endpoint para deletar uma postagem por ID
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deletarPostagem(@PathVariable Integer id) {
        try {
            postagemService.deletePostagemById(id);
            return ResponseEntity.ok("Postagem deletada com sucesso.");
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/usuario/{idUsuario}")
    public List<Postagem> getPostagensByUsuario(@PathVariable Integer idUsuario) {
        return postagemService.getPostagensByUsuarioId(idUsuario);
    }
}
