package br.com.hommei.entity;

import br.com.hommei.enuns.RoleEnum;
import br.com.hommei.enuns.SexoOpcao;
import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.br.CPF;

import java.time.LocalDate;

@Data
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "USUARIO")
@Inheritance(strategy = InheritanceType.JOINED)
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_USUARIO")
    private Integer idUsuario;

    @NotBlank
    @Column(name = "NOME")
    private String nome;

    @Column(name = "SOBRENOME")
    private String sobrenome;

    @NotBlank
    @Column(name = "SENHA")
    private String senha;

    @Email
    @Column(name = "EMAIL_LOGIN")
    private String emailLogin;

    @Column(name = "TELEFONE")
    private String telefone;

    @CPF
    @Column(name = "CPF")
    private String cpf;

    @Column(name = "ENDERECO")
    private String endereco;

    @Column(name = "N_RESIDENCIAL", nullable = false)
    private Integer numResidencial;

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

    @Column(name = "STATUS_ROLE")
    @Enumerated(EnumType.STRING)
    private RoleEnum role;

    @Column(name = "DATA_DE_NASCIMENTO")
    private LocalDate dataDeNascimento;


    @Column(name = "SEXO")
    @Enumerated(EnumType.STRING)
    private SexoOpcao sexoOpcao;

    @Column(name = "CONF_SENHA")
    private String confSenha;


}
