package br.com.hommei.controller;

import br.com.hommei.entity.Categoria;
import br.com.hommei.entity.Servico;
import br.com.hommei.service.ServicoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/servicos")
@CrossOrigin(origins = "*")
public class ServicoController {

    @Autowired
    private ServicoService servicoService;

    @GetMapping("/categoria/{idCategoria}")
    public List<Servico> getServicosPorCategoria(@PathVariable Integer idCategorias) {
        Categoria categoria = new Categoria();
        categoria.setIdCategorias(idCategorias);
        return servicoService.buscarServicosPorCategoria(categoria);
    }
}
