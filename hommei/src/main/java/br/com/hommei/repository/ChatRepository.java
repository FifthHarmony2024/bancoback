package br.com.hommei.repository;

import br.com.hommei.entity.Chat;
import br.com.hommei.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ChatRepository extends JpaRepository<Chat, Integer> {
    boolean existsByUsuarioRemetenteAndUsuarioDestinatario(Usuario usuarioRemetente, Usuario usuarioDestinatario);

    List<Chat> findByUsuarioRemetente_IdUsuario(Integer idUsuario);

    List<Chat> findByUsuarioDestinatario_IdUsuario(Integer usuarioId);
    List<Chat> findAllByUsuarioRemetenteIdUsuarioOrUsuarioDestinatarioIdUsuario(Integer remetenteId, Integer destinatarioId);


}
