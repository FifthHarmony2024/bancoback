package br.com.hommei.service;

import br.com.hommei.entity.Chat;
import br.com.hommei.entity.Usuario;
import br.com.hommei.enuns.RoleEnum;
import br.com.hommei.repository.ChatRepository;
import br.com.hommei.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
@Service
public class ChatService {

    @Autowired
    private ChatRepository chatRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    public ChatService(ChatRepository chatRepository, UsuarioRepository usuarioRepository) {
        this.chatRepository = chatRepository;
        this.usuarioRepository = usuarioRepository;
    }

    public Chat enviarMensagem(Chat chat) {
        Usuario remetente = usuarioRepository.findById(chat.getUsuarioRemetente().getIdUsuario())
                .orElseThrow(() -> new RuntimeException("Remetente não encontrado!"));
        Usuario destinatario = usuarioRepository.findById(chat.getUsuarioDestinatario().getIdUsuario())
                .orElseThrow(() -> new RuntimeException("Destinatário não encontrado!"));

        if (remetente == null || destinatario == null) {
            throw new RuntimeException("Não foi possível recuperar as informações dos usuários.");
        }

        if (remetente.getRoleEnum() == RoleEnum.CLIENTE) {
            if (destinatario.getRoleEnum() != RoleEnum.PRESTADOR) {
                throw new RuntimeException("Clientes só podem enviar mensagens para prestadores!");
            }
        } else if (remetente.getRoleEnum() == RoleEnum.PRESTADOR) {
            boolean clienteJaEnviouMensagem = chatRepository.existsByUsuarioRemetenteAndUsuarioDestinatario(
                    destinatario, remetente);
            if (!clienteJaEnviouMensagem) {
                throw new RuntimeException("Prestadores só podem responder a clientes que iniciaram a conversa!");
            }
        } else {
            throw new RuntimeException("Tipo de usuário não autorizado para enviar mensagens!");
        }

        chat.setUsuarioRemetente(remetente);
        chat.setUsuarioDestinatario(destinatario);
        chat.setTimestamp(LocalDateTime.now());


        return chatRepository.save(chat);
    }

    public List<Chat> getMessagesByUser(Integer usuarioId) {
        return chatRepository.findByUsuarioRemetente_IdUsuario(usuarioId);
    }

    public List<Chat> getMessagesForPrestador(Integer idUsuario) {
        List<Chat> chats = chatRepository.findByUsuarioDestinatario_IdUsuario(idUsuario);

        for (Chat chat : chats) {
            Usuario cliente = chat.getUsuarioRemetente();
        }

        return chats;
    }

    public List<Chat> getMessagesForCliente(Integer idUsuario) {
        List<Chat> chats = chatRepository.findByUsuarioDestinatario_IdUsuario(idUsuario);

        for (Chat chat : chats) {
            Usuario prestador = chat.getUsuarioRemetente();
        }

        return chats;
    }

    public List<Chat> getAllMessagesForUser(Integer idUsuario) {
        return chatRepository.findAllByUsuarioRemetenteIdUsuarioOrUsuarioDestinatarioIdUsuario(idUsuario, idUsuario);
    }



}
