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

        // Mapeamento do DTO para a entidade Prestador
        Prestador prestador = modelMapper.map(prestadorDTO, Prestador.class);
        log.info("Dados do prestador após mapeamento: {}", prestador);

        // Cifrando a senha
        String senhaCifrada = passwordEncoder.encode(prestadorDTO.getSenha());
        log.info("Senha cifrada do prestador: {}", senhaCifrada);
        prestador.setSenha(senhaCifrada);

        prestador.setRole(RoleEnum.PRESTADOR);
        log.info("Role definida como PRESTADOR para o novo usuário.");

        PrestadorResponseDTO response = new PrestadorResponseDTO();

        // Validação do tipo de prestador
        if (prestador.getTipoPrestador() == TipoPrestador.AUTONOMO) {
            if (prestador.getCpf() == null || prestador.getCpf().isEmpty()) {
                response.setMensagemErro("CPF é obrigatório para autônomos.");
                log.warn("Erro no cadastro: CPF é obrigatório para autônomos.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }
            prestador.setCnpj(null); // Garantir que o CNPJ seja nulo para autônomos
        }

        if (prestador.getTipoPrestador() == TipoPrestador.MICROEMPREENDEDOR) {
            if (prestador.getCnpj() == null || prestador.getCnpj().isEmpty()) {
                response.setMensagemErro("CNPJ é obrigatório para microempreendedores.");
                log.warn("Erro no cadastro: CNPJ é obrigatório para microempreendedores.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }
            prestador.setCpf(null); // Garantir que o CPF seja nulo para microempreendedores
        }

        // Validação da categoria
        if (prestadorDTO.getIdCategoria() != null) {
            Categoria categoria = categoriaRepository.findById(prestadorDTO.getIdCategoria())
                    .orElseThrow(() -> new EntityNotFoundException("Categoria não encontrada"));
            prestador.setCategoria(categoria);
        } else {
            response.setMensagemErro("ID da categoria é obrigatório.");
            log.warn("Erro no cadastro: ID da categoria é obrigatório.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }

        // Validação e associação dos serviços
        if (prestadorDTO.getIdServico() != null && !prestadorDTO.getIdServico().isEmpty()) {
            List<Servico> servicos = new ArrayList<>();
            for (Integer idServico : prestadorDTO.getIdServico()) {
                Servico servico = servicoRepository.findById(idServico)
                        .orElseThrow(() -> new EntityNotFoundException("Serviço não encontrado"));
                servicos.add(servico);
            }
            prestador.setServico(servicos);
        }

        // Salvando o prestador no repositório
        Prestador prestadorSalvo = repository.save(prestador);
        log.info("Prestador salvo: {}", prestadorSalvo);

        // Mapeando o prestador salvo para o DTO de resposta
        response = modelMapper.map(prestadorSalvo, PrestadorResponseDTO.class);
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

    @Transactional
    public ResponseEntity<UsuarioResponseDTO> atualizarUsuario(Integer idUsuario, UsuarioAtualizacaoDTO atualizacaoDTO) {
        log.info("Atualizando informações do usuário com ID: {}", idUsuario);

        Usuario usuario = repository.findById(idUsuario)
                .orElseThrow(() -> new EntityNotFoundException("Usuário não encontrado"));

        if (atualizacaoDTO.getNome() != null) {
            usuario.setNome(atualizacaoDTO.getNome());
        }
        if (atualizacaoDTO.getSobrenome() != null) {
            usuario.setSobrenome(atualizacaoDTO.getSobrenome());
        }
        if (atualizacaoDTO.getSenha() != null) {
            String senhaCifrada = passwordEncoder.encode(atualizacaoDTO.getSenha());
            usuario.setSenha(senhaCifrada);
            log.info("Senha atualizada com sucesso.");
        }
        if (atualizacaoDTO.getEmailLogin() != null) {
            usuario.setEmailLogin(atualizacaoDTO.getEmailLogin());
        }
        if (atualizacaoDTO.getTelefone() != null) {
            usuario.setTelefone(atualizacaoDTO.getTelefone());
        }
        if (atualizacaoDTO.getEndereco() != null) {
            usuario.setEndereco(atualizacaoDTO.getEndereco());
        }
        if (atualizacaoDTO.getNumResidencial() != null) {
            usuario.setNumResidencial(atualizacaoDTO.getNumResidencial());
        }
        if (atualizacaoDTO.getBairro() != null) {
            usuario.setBairro(atualizacaoDTO.getBairro());
        }
        if (atualizacaoDTO.getComplementoResi() != null) {
            usuario.setComplementoResi(atualizacaoDTO.getComplementoResi());
        }
        if (atualizacaoDTO.getCep() != null) {
            usuario.setCep(atualizacaoDTO.getCep());
        }
        if (atualizacaoDTO.getCidade() != null) {
            usuario.setCidade(atualizacaoDTO.getCidade());
        }
        if (atualizacaoDTO.getEstado() != null) {
            usuario.setEstado(atualizacaoDTO.getEstado());
        }

        Usuario usuarioAtualizado = repository.save(usuario);
        log.info("Informações do usuário atualizadas: {}", usuarioAtualizado);

        UsuarioResponseDTO usuarioResponse = modelMapper.map(usuarioAtualizado, UsuarioResponseDTO.class);
        return ResponseEntity.status(HttpStatus.OK).body(usuarioResponse);
    }

    public ResponseEntity<?> buscarServicosOuPrestadores(String termoBusca, boolean buscarPrestadores) {
        log.info("Iniciando busca por termo: {}. Buscar Prestadores: {}", termoBusca, buscarPrestadores);

        if (termoBusca == null || termoBusca.trim().isEmpty()) {
            log.warn("Termo de busca vazio.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("O termo de busca não pode ser vazio.");
        }

        if (buscarPrestadores) {
            // Buscar prestadores que oferecem serviços correspondentes ao termo
            List<Prestador> prestadores = repository.buscarPrestadoresPorServico(termoBusca);
            if (prestadores.isEmpty()) {
                log.info("Nenhum prestador encontrado para o termo de busca: {}", termoBusca);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Nenhum prestador encontrado para o termo informado.");
            }
            List<PrestadorResponseDTO> prestadoresDTO = prestadores.stream()
                    .map(prestador -> modelMapper.map(prestador, PrestadorResponseDTO.class))
                    .toList();
            return ResponseEntity.ok(prestadoresDTO);
        } else {
            // Buscar serviços pelo nome ou descrição
            List<Servico> servicos = servicoRepository.buscarServicosPorNomeOuDescricao(termoBusca);
            if (servicos.isEmpty()) {
                log.info("Nenhum serviço encontrado para o termo de busca: {}", termoBusca);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Nenhum serviço encontrado para o termo informado.");
            }
            // Retornar diretamente a entidade Servico
            return ResponseEntity.ok(servicos);
        }
    }


}
