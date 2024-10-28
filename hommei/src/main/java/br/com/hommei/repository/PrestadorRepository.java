package br.com.hommei.repository;

import br.com.hommei.entity.Prestador;
import br.com.hommei.entity.Servico;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PrestadorRepository extends JpaRepository<Prestador,Integer> {
    List<Prestador> findByServico(Servico servico);
}
