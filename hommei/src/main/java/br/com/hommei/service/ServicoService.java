package br.com.hommei.service;

import br.com.hommei.dto.PrestadorResponseDTO;
import br.com.hommei.entity.Categoria;
import br.com.hommei.entity.Prestador;
import br.com.hommei.entity.Servico;
import br.com.hommei.mapper.ModelMapperCustom;
import br.com.hommei.repository.PrestadorRepository;
import br.com.hommei.repository.ServicoRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ServicoService {

    @Autowired
    private ServicoRepository servicoRepository;

    @Autowired
    private PrestadorRepository prestadorRepository;

    @Autowired
    private ModelMapperCustom modelMapper;

    public List<Servico> buscarServicosPorCategoria(Categoria categoria) {
        return servicoRepository.findByIdCate(categoria);
    }


}

