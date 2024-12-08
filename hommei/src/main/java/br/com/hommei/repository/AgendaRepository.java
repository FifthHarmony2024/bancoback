package br.com.hommei.repository;

import br.com.hommei.entity.Agenda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.Optional;

@Repository
public interface AgendaRepository extends JpaRepository<Agenda, Integer> {

    Optional<Agenda> findByUsuarioIdUsuarioAndDiaServico(Integer idUsuario, Date diaServico);
}
