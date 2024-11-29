package br.com.hommei.service;

import br.com.hommei.entity.Postagem;
import br.com.hommei.entity.Usuario;
import br.com.hommei.repository.PostagemRepository;
import br.com.hommei.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PostagemService {

    @Autowired
    private PostagemRepository postagemRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    public void savePostagem(Postagem postagem) {
        postagemRepository.save(postagem);
    }

    public List<Postagem> getAllPostagens() {
        return postagemRepository.findAll();
    }

    public Postagem getPostagemById(Integer id) {
        return postagemRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Postagem não encontrada."));
    }

    public void deletePostagemById(Integer id) {
        Postagem postagem = getPostagemById(id);
        postagemRepository.delete(postagem);
    }

    public Usuario getUsuarioById(Integer id) {
        return usuarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado."));
    }

    public List<Postagem> getPostagensByUsuarioId(Integer idUsuario) {
        Usuario usuario = usuarioRepository.findById(idUsuario)
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado."));
        return postagemRepository.findByUsuario(usuario);
    }

    public List<Postagem> getPostagensByPrestadorId(Integer idUsuario) {
        Usuario prestador = usuarioRepository.findById(idUsuario)
                .orElseThrow(() -> new RuntimeException("Prestador não encontrado."));

        if (!(prestador instanceof Usuario)) {
            throw new IllegalArgumentException("O ID fornecido não pertence a um prestador.");
        }

        return postagemRepository.findByUsuario(prestador);
    }

}
