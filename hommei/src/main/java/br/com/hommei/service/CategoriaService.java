package br.com.hommei.service;

import br.com.hommei.entity.Categoria;
import br.com.hommei.entity.Servico;
import br.com.hommei.repository.CategoriaRepository;
import br.com.hommei.repository.ServicoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CategoriaService {

    @Autowired
    private CategoriaRepository categoriaRepository;

    @Autowired
    private ServicoRepository servicoRepository;

    public List<Categoria> listarCategorias() {
        return categoriaRepository.findAll();
    }

    public Optional<Categoria> buscarPorId(Integer idCategoria) {
        return categoriaRepository.findById(idCategoria);
    }

}
