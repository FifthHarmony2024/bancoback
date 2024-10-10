package br.com.hommei.service;

import br.com.hommei.config.ModelMapperConfig;
import br.com.hommei.dto.PrestadorResponseDTO;
import br.com.hommei.dto.UsuarioInsercaoDTO;
import br.com.hommei.dto.UsuarioResponseDTO;
import br.com.hommei.dto.PrestadorInsercaoDTO;
import br.com.hommei.entity.Prestador;
import br.com.hommei.entity.Usuario;
import br.com.hommei.enuns.TipoPrestador;
import br.com.hommei.mapper.ModelMapperCustom;
import br.com.hommei.repository.UsuarioRepository;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository repository;

    @Autowired
    private ModelMapperCustom modelMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;


    public ResponseEntity<UsuarioResponseDTO> cadastrarCliente(UsuarioInsercaoDTO usuarioDTO) {
        Usuario usuario = modelMapper.map(usuarioDTO, Usuario.class);

        String senhaCifrada = passwordEncoder.encode(usuarioDTO.getSenha());
        log.info("Senha Cifrada => {}", senhaCifrada);

        usuario.setSenha(senhaCifrada);
        Usuario clienteSalvo = repository.save(usuario);
        log.info("Cliente salvo: {}", clienteSalvo);

        UsuarioResponseDTO usuarioResponse = modelMapper.map(clienteSalvo, UsuarioResponseDTO.class);
        return ResponseEntity.status(HttpStatus.CREATED).body(usuarioResponse);
    }

    public ResponseEntity<PrestadorResponseDTO> cadastrarPrestador(PrestadorInsercaoDTO prestadorDTO) {
        Prestador prestador = modelMapper.map(prestadorDTO, Prestador.class);

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

        String senhaCifrada = passwordEncoder.encode(prestadorDTO.getSenha());
        log.info("Senha Cifrada para Prestador => {}", senhaCifrada);

        prestador.setSenha(senhaCifrada);

        Prestador prestadorSalvo = repository.save(prestador);

        PrestadorResponseDTO prestadorResponse = modelMapper.map(prestadorSalvo, PrestadorResponseDTO.class);
        return ResponseEntity.status(HttpStatus.CREATED).body(prestadorResponse);
    }

}
