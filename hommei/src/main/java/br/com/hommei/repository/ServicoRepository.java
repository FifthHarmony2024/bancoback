package br.com.hommei.repository;

import br.com.hommei.entity.Categoria;
import br.com.hommei.entity.Servico;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ServicoRepository extends JpaRepository<Servico,Integer> {
        List<Servico> findByIdCate(Categoria categoria);

}
