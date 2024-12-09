package br.com.hommei.repository;

import br.com.hommei.entity.Agendamento;
import br.com.hommei.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AgendamentoRepository extends JpaRepository<Agendamento, Integer> {
    List<Agendamento> findByUsuario(Usuario usuario);

}
