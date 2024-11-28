package br.com.hommei.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "CHAT")
public class Chat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_CHAT")
    private Integer idChat;

    @Column(name = "MESSAGE_CHAT")
    private String  messagemChat;

    @Column(name = "TIMESTAMP")
    private LocalDateTime timestamp;

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO")
    private Usuario usuario;


}
