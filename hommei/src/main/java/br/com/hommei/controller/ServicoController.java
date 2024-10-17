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
    public List<Servico> getServicosPorCategoria(@PathVariable Integer idCategoria) {
        Categoria categoria = new Categoria();
        categoria.setIdCategoria(idCategoria);
        return servicoService.buscarServicosPorCategoria(categoria);
    }
}
