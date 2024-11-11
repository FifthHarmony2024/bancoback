package br.com.hommei.service;

import br.com.hommei.config.ModelMapperConfig;
import br.com.hommei.dto.PrestadorResponseDTO;
import br.com.hommei.dto.UsuarioInsercaoDTO;
import br.com.hommei.dto.UsuarioResponseDTO;
import br.com.hommei.dto.PrestadorInsercaoDTO;
import br.com.hommei.entity.Categoria;
import br.com.hommei.entity.Prestador;
import br.com.hommei.entity.Servico;
import br.com.hommei.entity.Usuario;
import br.com.hommei.enuns.RoleEnum;
import br.com.hommei.enuns.TipoPrestador;
import br.com.hommei.mapper.ModelMapperCustom;
import br.com.hommei.repository.CategoriaRepository;
import br.com.hommei.repository.ServicoRepository;
import br.com.hommei.repository.UsuarioRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
/*
import org.springframework.security.crypto.password.PasswordEncoder;
*/
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository repository;

    @Autowired
    private ModelMapperCustom modelMapper;

    @Autowired
    private CategoriaRepository categoriaRepository;

    @Autowired
    private ServicoRepository servicoRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;


    public ResponseEntity<UsuarioResponseDTO> cadastrarCliente(UsuarioInsercaoDTO usuarioDTO) {
        log.info("Dados do usuário recebidos: {}", usuarioDTO);

        Usuario usuario = modelMapper.map(usuarioDTO, Usuario.class);
        log.info("Dados do usuário após mapeamento: {}", usuario);

        String senhaCifrada = passwordEncoder.encode(usuarioDTO.getSenha());
        log.info("Senha Cifrada => {}", senhaCifrada);

        // Definir a role como CLIENTE
        usuario.setRole(RoleEnum.CLIENTE);
        log.info("Role definida como CLIENTE para o novo usuário.");

        usuario.setSenha(senhaCifrada);

        Usuario clienteSalvo = repository.save(usuario);
        log.info("Cliente salvo: {}", clienteSalvo);

        UsuarioResponseDTO usuarioResponse = modelMapper.map(clienteSalvo, UsuarioResponseDTO.class);
        return ResponseEntity.status(HttpStatus.CREATED).body(usuarioResponse);
    }

    public ResponseEntity<PrestadorResponseDTO> cadastrarPrestador(PrestadorInsercaoDTO prestadorDTO) {
        log.info("Dados do prestador recebidos: {}", prestadorDTO);

        Prestador prestador = modelMapper.map(prestadorDTO, Prestador.class);
        log.info("Dados do prestador após mapeamento: {}", prestador);

        // Criptografia da senha
        String senhaCifrada = passwordEncoder.encode(prestadorDTO.getSenha());
        log.info("Senha cifrada do prestador: {}", senhaCifrada);
        prestador.setSenha(senhaCifrada);

        PrestadorResponseDTO response = new PrestadorResponseDTO();

        // Validações para CPF e CNPJ
        if (prestador.getTipoPrestador() == TipoPrestador.AUTONOMO) {
            if (prestador.getCpf() == null || prestador.getCpf().isEmpty()) {
                response.setMensagemErro("CPF é obrigatório para autônomos.");
                log.warn("Erro no cadastro: CPF é obrigatório para autônomos.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }
            prestador.setCnpj(null);
        }

        if (prestador.getTipoPrestador() == TipoPrestador.MICROEMPREENDEDOR) {
            if (prestador.getCnpj() == null || prestador.getCnpj().isEmpty()) {
                response.setMensagemErro("CNPJ é obrigatório para microempreendedores.");
                log.warn("Erro no cadastro: CNPJ é obrigatório para microempreendedores.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }
            prestador.setCpf(null);
        }

        if (prestadorDTO.getIdCategoria() != null) {
            Categoria categoria = categoriaRepository.findById(prestadorDTO.getIdCategoria())
                    .orElseThrow(() -> new EntityNotFoundException("Categoria não encontrada"));
            prestador.setCategoria(categoria);
        } else {
            response.setMensagemErro("ID da categoria é obrigatório.");
            log.warn("Erro no cadastro: ID da categoria é obrigatório.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }

        if (prestadorDTO.getIdServico() != null && !prestadorDTO.getIdServico().isEmpty()) {
            List<Servico> servicos = new ArrayList<>();
            for (Integer idServico : prestadorDTO.getIdServico()) {
                Servico servico = servicoRepository.findById(idServico)
                        .orElseThrow(() -> new EntityNotFoundException("Serviço não encontrado"));
                servicos.add(servico);
            }
            prestador.setServico(servicos);
        }

        Prestador prestadorSalvo = repository.save(prestador);
        log.info("Prestador salvo: {}", prestadorSalvo);

        response = modelMapper.map(prestadorSalvo, PrestadorResponseDTO.class);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    public ResponseEntity<UsuarioResponseDTO> buscarUsuarioPorId(Integer idUsuario) {
        log.info("Buscando dados do usuário com ID: {}", idUsuario);

        Usuario usuario = repository.findById(idUsuario)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));

        UsuarioResponseDTO usuarioResponse = modelMapper.map(usuario, UsuarioResponseDTO.class);

        // Garante que o usuário foi encontrado e o DTO está populado
        if (usuarioResponse == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }

        return ResponseEntity.status(HttpStatus.OK).body(usuarioResponse);
    }

    public ResponseEntity<UsuarioResponseDTO> getUsuarioLogado() {
        // Obtém a autenticação do usuário logado
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        // Se a autenticação for nula, significa que o usuário não está autenticado
        if (authentication == null) {
            log.error("Usuário não autenticado.");
            return ResponseEntity.status(403).body(null);  // Forbidden (403)
        }

        // Obtém o login (normalmente o email) a partir do token JWT
        String login = authentication.getName();
        log.info("Usuário logado: {}", login);

        // Busca o usuário pelo login
        Usuario usuario = repository.findByEmailLogin(login)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));

        // Mapeia a entidade para o DTO
        UsuarioResponseDTO usuarioResponse = modelMapper.map(usuario, UsuarioResponseDTO.class);

        // Retorna as informações do usuário
        return ResponseEntity.ok(usuarioResponse);
    }
}
