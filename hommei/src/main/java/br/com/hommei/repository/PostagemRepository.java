package br.com.hommei.repository;

import br.com.hommei.entity.Postagem;
import br.com.hommei.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;


public interface PostagemRepository extends JpaRepository<Postagem, Integer> {
    List<Postagem> findByUsuario(Usuario usuario);

}
