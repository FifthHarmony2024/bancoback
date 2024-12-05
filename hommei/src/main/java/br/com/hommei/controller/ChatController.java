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

    @PostMapping("/enviar")
    public ResponseEntity<Chat> enviarMensagem(@RequestBody Chat chat) {
        try {
            Chat mensagemEnviada = chatService.enviarMensagem(chat);
            return new ResponseEntity<>(mensagemEnviada, HttpStatus.CREATED);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/usuario/{idUsuario}")
    public ResponseEntity<List<Chat>> getMessagesForUser(@PathVariable Integer idUsuario) {
        try {
            List<Chat> mensagens = chatService.getAllMessagesForUser(idUsuario);
            return new ResponseEntity<>(mensagens, HttpStatus.OK);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
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
