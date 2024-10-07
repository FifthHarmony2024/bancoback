package br.com.hommei.service;

import br.com.hommei.dto.PrestadorResponseDTO;
import br.com.hommei.dto.UsuarioResponseDTO;
import br.com.hommei.entity.Prestador;
import br.com.hommei.entity.Usuario;
import br.com.hommei.enuns.TipoPrestador;
import br.com.hommei.repository.UsuarioRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository repository;

    private ModelMapper modelMapper = new ModelMapper();


    public ResponseEntity<Usuario> cadastrarCliente(Usuario usuario) {
        Usuario clienteSalvo = repository.save(usuario);
        return ResponseEntity.status(HttpStatus.CREATED).body(clienteSalvo);
    }

    public ResponseEntity<Prestador> cadastrarPrestador(Prestador prestador) {
        if (prestador.getTipoPrestador() == TipoPrestador.AUTONOMO) {
            if (prestador.getCpf() == null || prestador.getCpf().isEmpty()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
            }
            prestador.setCnpj(null);
        }

        if (prestador.getTipoPrestador() == TipoPrestador.MICROEMPREENDEDOR) {
            if (prestador.getCnpj() == null || prestador.getCnpj().isEmpty()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
            }
            prestador.setCpf(null);
        }

        Prestador prestadorSalvo = repository.save(prestador);
        return ResponseEntity.status(HttpStatus.CREATED).body(prestadorSalvo);
    }
    public List<UsuarioResponseDTO> listar() {
        var usuarios = repository.findAll();
        return usuarios.stream().map(usuario -> {
            if (usuario instanceof Prestador) {
                return modelMapper.map(usuario, PrestadorResponseDTO.class);
            } else {
                return modelMapper.map(usuario, UsuarioResponseDTO.class);
            }
        }).collect(Collectors.toList());
    }


}
