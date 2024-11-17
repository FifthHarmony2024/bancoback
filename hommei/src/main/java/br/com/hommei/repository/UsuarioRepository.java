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

    @Query("SELECT p FROM Prestador p JOIN p.servico s " +
            "WHERE LOWER(s.nomeServico) LIKE LOWER(CONCAT('%', :termoBusca, '%')) " +
            "OR LOWER(s.descricaoServico) LIKE LOWER(CONCAT('%', :termoBusca, '%'))")
    List<Prestador> buscarPrestadoresPorServico(@Param("termoBusca") String termoBusca);


}
