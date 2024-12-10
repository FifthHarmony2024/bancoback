package br.com.hommei.repository;

import br.com.hommei.entity.Agenda;
import br.com.hommei.entity.Prestador;
import br.com.hommei.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface AgendaRepository extends JpaRepository<Agenda, Integer> {
    Optional<Agenda> findByUsuario_IdUsuario(Integer idUsuario);


}