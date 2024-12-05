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

    @Column(name = "MESSAGEM_CHAT")
    private String  messagemChat;

    @Column(name = "TIMESTAMP")
    private LocalDateTime timestamp;

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO_REMETENTE", referencedColumnName = "ID_USUARIO", nullable = false)
    private Usuario usuarioRemetente;

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO_DESTINATARIO", referencedColumnName = "ID_USUARIO", nullable = false)
    private Usuario usuarioDestinatario;


}
