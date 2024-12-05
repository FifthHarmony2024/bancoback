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

        // Salvar a mensagem com os dados completos dos usuários
        chat.setUsuarioRemetente(remetente);
        chat.setUsuarioDestinatario(destinatario);
        chat.setTimestamp(LocalDateTime.now());

        // Aqui você pode adicionar mais detalhes ao salvar, como garantir que outras entidades relacionadas sejam carregadas

        return chatRepository.save(chat);
    }

    public List<Chat> getMessagesByUser(Integer usuarioId) {
        // Busca todas as mensagens de um usuário, considerando tanto mensagens enviadas quanto recebidas
        return chatRepository.findByUsuarioRemetente_IdUsuario(usuarioId);
    }

    // Buscar mensagens específicas de um prestador
    // Dentro do ChatService, crie um método para buscar mensagens para o prestador
    public List<Chat> getMessagesForPrestador(Integer idUsuario) {
        // Aqui você busca todas as mensagens em que o prestador é o destinatário
        List<Chat> chats = chatRepository.findByUsuarioDestinatario_IdUsuario(idUsuario);

        // Aqui você pode carregar mais informações, caso necessário (como nome do cliente)
        for (Chat chat : chats) {
            Usuario cliente = chat.getUsuarioRemetente();
            // Você pode garantir que as informações do cliente estão carregadas
        }

        return chats;
    }

    public List<Chat> getMessagesForCliente(Integer idUsuario) {
        // Busca todas as mensagens em que o cliente é o destinatário
        List<Chat> chats = chatRepository.findByUsuarioDestinatario_IdUsuario(idUsuario);

        // Carregar as informações do prestador (remetente), se necessário
        for (Chat chat : chats) {
            Usuario prestador = chat.getUsuarioRemetente();
            // Você pode carregar mais informações do prestador, caso necessário
        }

        return chats;
    }



}
