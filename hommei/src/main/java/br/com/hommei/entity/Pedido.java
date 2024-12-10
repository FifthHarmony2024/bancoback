package br.com.hommei.entity;

import br.com.hommei.enuns.StatusServico;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "PEDIDO")
public class Pedido {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_PEDIDO")
    private Integer idPedido;

    @Enumerated(EnumType.STRING)
    @Column(name = "STATUS_SERVICO")
    private StatusServico statusServico;

    @Column(name = "CATEGORIA_PEDIDO")
    private String categoriaPedido;

    @Column(name = "DESCRICAO_PEDIDO")
    private String descricaoPedido;

    @Column(name = "ENDERECO")
    private String endereco;

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO")
    private Usuario id;

    @ManyToOne
    @JoinColumn(name = "ID_AGENDA")
    private Agenda idAgenda;
}
