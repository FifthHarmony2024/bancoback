package br.com.hommei.repository;

import br.com.hommei.entity.Prestador;
import br.com.hommei.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    Optional<Usuario> findByEmailLogin(String emailLogin);

    List<Prestador> findByNomeComercialContainingIgnoreCaseOrCategoriaNomeCategoriaContainingIgnoreCaseOrServicoNomeServicoContainingIgnoreCaseOrServicoDescricaoServicoContainingIgnoreCase(
            String nomeComercial, String nomeCategoria, String nomeServico, String descricaoServico);


}
