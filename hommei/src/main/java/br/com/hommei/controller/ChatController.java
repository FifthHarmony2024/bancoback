package br.com.hommei.controller;

import br.com.hommei.entity.Chat;
import br.com.hommei.service.ChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    private ChatService chatService;

    // Endpoint para enviar uma mensagem
    @PostMapping("/enviar")
    public ResponseEntity<Chat> enviarMensagem(@RequestBody Chat chat) {
        try {
            // Chama o serviço para enviar a mensagem
            Chat mensagemEnviada = chatService.enviarMensagem(chat);
            return new ResponseEntity<>(mensagemEnviada, HttpStatus.CREATED);  // Retorna 201 caso a mensagem seja salva com sucesso
        } catch (RuntimeException e) {
            // Retorna erro 400 em caso de exceção
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }
    }

    // Endpoint para buscar mensagens de um usuário específico
    @GetMapping("/usuario/{idUsuario}")
    public ResponseEntity<List<Chat>> getMessagesByUser(@PathVariable Integer idUsuario) {
        try {
            List<Chat> mensagens = chatService.getMessagesByUser(idUsuario);
            return new ResponseEntity<>(mensagens, HttpStatus.OK);  // Retorna as mensagens encontradas
        } catch (RuntimeException e) {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);  // Retorna erro caso não consiga buscar as mensagens
        }
    }

    @GetMapping("/prestador/{idUsuario}")
    public List<Chat> getMessagesForPrestador(@PathVariable Integer idUsuario) {
        return chatService.getMessagesForPrestador(idUsuario);
    }

    @GetMapping("/cliente/{idUsuario}")
    public List<Chat> getMessagesForCliente(@PathVariable Integer idUsuario) {
        return chatService.getMessagesForCliente(idUsuario);
    }
}
