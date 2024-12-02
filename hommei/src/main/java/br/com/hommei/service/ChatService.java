package br.com.hommei.service;

import br.com.hommei.entity.Chat;
import br.com.hommei.repository.ChatRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@Slf4j
public class ChatService {

    @Autowired
    private ChatRepository chatRepository;

    public Chat saveMessage(Chat message) {
        message.setTimestamp(LocalDateTime.now());
        return chatRepository.save(message);

    }
}
