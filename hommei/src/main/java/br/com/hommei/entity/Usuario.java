package br.com.hommei.entity;

import br.com.hommei.enuns.SexoOpcao;
import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import org.hibernate.validator.constraints.br.CPF;

import java.time.LocalDate;

@Data
@Entity
@Table(name = "USUARIO")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_USUARIO")
    private Integer idUsuario;

    @NotBlank
    @Column(name = "NOME")
    private String nome;

    @NotBlank
    @Column(name = "SOBRENOME")
    private String sobrenome;

    @NotBlank
    @Column(name = "SENHA")
    private String senha;

    @Email
    @Column(name = "EMAIL")
    private String email;

    @Column(name = "TELEFONE")
    private String telefone;

    @CPF
    @Column(name = "CPF")
    private String cpf;

    @NotBlank
    @Column(name = "ENDERECO")
    private String endereco;

    @Column(name = "N_RESIDENCIAL")
    private Integer nResidencial;

    @NotBlank
    @Column(name = "BAIRRO")
    private String bairro;

    @Column(name = "COMPLEMENTO_RESI")
    private String complementoResi;

    @Column(name = "CEP")
    private String cep;

    @Column(name = "CIDADE")
    private String cidade;

    @Column(name = "ESTADO")
    private String estado;

    @Column(name = "DATA_NASCIMENTO")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy")
    private LocalDate dataNascimento;

    @Column(name = "SEXO")
    @Enumerated(EnumType.ORDINAL)
    private SexoOpcao sexoOpcao;

    @NotBlank
    @Transient
    private String confSenha;

}
