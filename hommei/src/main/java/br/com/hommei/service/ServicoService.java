package br.com.hommei.service;

import br.com.hommei.entity.Categoria;
import br.com.hommei.entity.Servico;
import br.com.hommei.repository.ServicoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ServicoService {

    @Autowired
    private ServicoRepository servicoRepository;

    public List<Servico> buscarServicosPorCategoria(Categoria categoria) {
        return servicoRepository.findByIdCate(categoria);
    }


}
