package br.com.hommei.repository;

import br.com.hommei.entity.Categoria;
import br.com.hommei.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CategoriaRepository extends JpaRepository<Categoria,Integer> {

}
