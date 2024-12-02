package br.com.hommei.controller;

import br.com.hommei.dto.PrestadorResponseDTO;
import br.com.hommei.entity.Categoria;
import br.com.hommei.entity.Servico;
import br.com.hommei.service.CategoriaService;
import br.com.hommei.service.ServicoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/servicos")
@CrossOrigin(origins = "*")
public class ServicoController {

    @Autowired
    private ServicoService servicoService;

    @Autowired
    private CategoriaService categoriaService;

    @GetMapping("/categoria/{idCategoria}")
    public ResponseEntity<List<Servico>> getServicosPorCategoria(@PathVariable Integer idCategoria) {
        Optional<Categoria> categoriaOptional = categoriaService.buscarPorId(idCategoria);

        if (!categoriaOptional.isPresent()) {
            return ResponseEntity.notFound().build();
        }

        List<Servico> servicos = servicoService.buscarServicosPorCategoria(categoriaOptional.get());
        return ResponseEntity.ok(servicos);
    }

}
