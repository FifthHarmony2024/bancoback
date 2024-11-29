package br.com.hommei.service;

import br.com.hommei.dto.*;
import br.com.hommei.entity.Categoria;
import br.com.hommei.entity.Prestador;
import br.com.hommei.entity.Servico;
import br.com.hommei.entity.Usuario;
import br.com.hommei.enuns.RoleEnum;
import br.com.hommei.enuns.TipoPrestador;
import br.com.hommei.mapper.ModelMapperCustom;
import br.com.hommei.repository.CategoriaRepository;
import br.com.hommei.repository.PrestadorRepository;
import br.com.hommei.repository.ServicoRepository;
import br.com.hommei.repository.UsuarioRepository;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

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

    @Autowired
    private PrestadorRepository prestadorRepository;

    @Autowired
    private FileStorageService fileStorageService;

    public ResponseEntity<UsuarioResponseDTO> cadastrarCliente(UsuarioInsercaoDTO usuarioDTO) {
        log.info("Dados do usuário recebidos: {}", usuarioDTO);

        Usuario usuario = modelMapper.map(usuarioDTO, Usuario.class);
        log.info("Dados do usuário após mapeamento: {}", usuario);

        String senhaCifrada = passwordEncoder.encode(usuarioDTO.getSenha());
        log.info("Senha Cifrada => {}", senhaCifrada);

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

        String senhaCifrada = passwordEncoder.encode(prestadorDTO.getSenha());
        log.info("Senha cifrada do prestador: {}", senhaCifrada);
        prestador.setSenha(senhaCifrada);

        prestador.setRole(RoleEnum.PRESTADOR);
        log.info("Role definida como PRESTADOR para o novo usuário.");

        PrestadorResponseDTO response = new PrestadorResponseDTO();

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
                        .orElseThrow(() -> new EntityNotFoundException("Serviço não encontrado: " + idServico));
                servicos.add(servico);
            }
            prestador.setServico(servicos);
        } else {
            response.setMensagemErro("ID dos serviços é obrigatório.");
            log.warn("Erro no cadastro: ID dos serviços é obrigatório.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }

        Prestador prestadorSalvo = repository.save(prestador);
        log.info("Prestador salvo: {}", prestadorSalvo);

        response = modelMapper.map(prestadorSalvo, PrestadorResponseDTO.class);

        if (prestadorSalvo.getCategoria() != null) {
            response.setNomeCategoria(prestadorSalvo.getCategoria().getNomeCategoria());
        }

        if (prestadorSalvo.getServico() != null && !prestadorSalvo.getServico().isEmpty()) {
            List<String> nomesServicos = prestadorSalvo.getServico().stream()
                    .map(Servico::getNomeServico)
                    .collect(Collectors.toList());
            response.setNomeServico(nomesServicos);
        } else {
            response.setNomeServico(Collections.emptyList());
        }

        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    public ResponseEntity<UsuarioResponseDTO> buscarUsuarioPorId(Integer idUsuario) {
        log.info("Buscando dados do usuário com ID: {}", idUsuario);

        Usuario usuario = repository.findById(idUsuario)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));

        UsuarioResponseDTO usuarioResponse = modelMapper.map(usuario, UsuarioResponseDTO.class);

        if (usuarioResponse == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }

        return ResponseEntity.status(HttpStatus.OK).body(usuarioResponse);
    }

    public ResponseEntity<UsuarioResponseDTO> buscarDadosPerfil(Integer idUsuario) {
        log.info("Buscando dados do perfil para o usuário com ID: {}", idUsuario);

        Usuario usuario = repository.findById(idUsuario)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));

        if (usuario.getFotoPerfil() == null || usuario.getFotoPerfil().isEmpty()) {
            usuario.setFotoPerfil("fotoPerfil/fotoPadrao.png");
        }

        UsuarioResponseDTO usuarioResponse = modelMapper.map(usuario, UsuarioResponseDTO.class);

        log.info("Dados do perfil do usuário: {}", usuarioResponse);

        return ResponseEntity.ok(usuarioResponse);
    }

    public ResponseEntity<?> buscarDadosPerfilPrestador(Integer idUsuario) {
        log.info("Buscando dados do perfil do prestador com ID: {}", idUsuario);

        Usuario usuario = repository.findById(idUsuario)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));

        if (!(usuario instanceof Prestador)) {
            throw new IllegalArgumentException("O usuário com ID " + idUsuario + " não é um prestador.");
        }

        Prestador prestador = (Prestador) usuario;

        if (prestador.getFotoPerfil() == null || prestador.getFotoPerfil().isEmpty()) {
            prestador.setFotoPerfil("fotoPerfil/fotoPadrao.png");
        }

        PrestadorResponseDTO prestadorResponse = modelMapper.map(prestador, PrestadorResponseDTO.class);

        if (prestador.getCategoria() != null) {
            prestadorResponse.setNomeCategoria(prestador.getCategoria().getNomeCategoria());
        }

        if (prestador.getServico() != null && !prestador.getServico().isEmpty()) {
            List<String> nomesServicos = prestador.getServico().stream()
                    .map(Servico::getNomeServico)
                    .collect(Collectors.toList());
            prestadorResponse.setNomeServico(nomesServicos);
        } else {
            prestadorResponse.setNomeServico(Collections.emptyList());
        }

        log.info("Dados do perfil do prestador: {}", prestadorResponse);

        return ResponseEntity.ok(prestadorResponse);
    }


    public ResponseEntity<?> buscarPrestadoresPorNomeComercialOuCategoriaOuServico(String termoBusca) {
        log.info("Buscando prestadores pelo termo: {}", termoBusca);

        if (termoBusca == null || termoBusca.trim().isEmpty()) {
            log.warn("Termo de busca vazio.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("O termo de busca não pode ser vazio.");
        }

        List<Prestador> prestadores = repository.findByNomeComercialContainingIgnoreCaseOrCategoriaNomeCategoriaContainingIgnoreCaseOrServicoNomeServicoContainingIgnoreCaseOrServicoDescricaoServicoContainingIgnoreCase(
                termoBusca, termoBusca, termoBusca, termoBusca);

        if (prestadores.isEmpty()) {
            log.info("Nenhum prestador encontrado para o termo de busca: {}", termoBusca);
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Nenhum prestador encontrado com o termo informado.");
        }

        // Mapear os prestadores para DTOs e incluir os nomes dos serviços e da categoria.
        List<PrestadorResponseDTO> prestadoresDTO = prestadores.stream().map(prestador -> {
            PrestadorResponseDTO prestadorDTO = modelMapper.map(prestador, PrestadorResponseDTO.class);

            // Adicionando o nome da categoria
            if (prestador.getCategoria() != null) {
                prestadorDTO.setNomeCategoria(prestador.getCategoria().getNomeCategoria());
            }

            // Adicionando os nomes dos serviços
            if (prestador.getServico() != null && !prestador.getServico().isEmpty()) {
                List<String> nomesServicos = prestador.getServico().stream()
                        .map(Servico::getNomeServico)
                        .collect(Collectors.toList());
                prestadorDTO.setNomeServico(nomesServicos);
            } else {
                prestadorDTO.setNomeServico(Collections.emptyList());
            }

            return prestadorDTO;
        }).toList();

        log.info("Resultado da busca: {}", prestadoresDTO);

        return ResponseEntity.ok(prestadoresDTO);
    }


    @Transactional
    public ResponseEntity<String> adicionarFotoPerfil(Integer idUsuario, MultipartFile file) {
        log.info("Adicionando foto de perfil para o usuário com ID: {}", idUsuario);

        if (file == null || file.isEmpty()) {
            log.warn("Arquivo de imagem vazio ou nulo.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Arquivo de imagem é obrigatório.");
        }

        Usuario usuario = repository.findById(idUsuario)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));

        try {
            String filePath = fileStorageService.saveFile(file);

            usuario.setFotoPerfil(filePath);
            repository.save(usuario);

            log.info("Foto de perfil adicionada com sucesso para o usuário ID: {}", idUsuario);
            return ResponseEntity.status(HttpStatus.OK).body("Foto de perfil atualizada com sucesso.");

        } catch (IOException e) {
            log.error("Erro ao salvar a foto de perfil: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao salvar a foto de perfil.");
        }
    }

    @Transactional
    public ResponseEntity<String> getFotoPerfilByUsuarioId(Integer idUsuario) {
        Usuario usuario = repository.findById(idUsuario)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado."));

        String fotoPerfil = usuario.getFotoPerfil();

        if (fotoPerfil == null || fotoPerfil.isEmpty()) {
            return ResponseEntity.ok("uploads/fotoPadrao.png");
        }

        return ResponseEntity.ok(fotoPerfil);
    }


}
