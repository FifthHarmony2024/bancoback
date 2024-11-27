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

    // Salva uma nova postagem
    public void savePostagem(Postagem postagem) {
        postagemRepository.save(postagem);
    }

    // Busca todas as postagens
    public List<Postagem> getAllPostagens() {
        return postagemRepository.findAll();
    }

    // Busca uma postagem pelo ID
    public Postagem getPostagemById(Integer id) {
        return postagemRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Postagem não encontrada."));
    }

    // Deleta uma postagem pelo ID
    public void deletePostagemById(Integer id) {
        Postagem postagem = getPostagemById(id);
        postagemRepository.delete(postagem);
    }

    // Busca um usuário pelo ID
    public Usuario getUsuarioById(Integer id) {
        return usuarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado."));
    }

    public List<Postagem> getPostagensByUsuarioId(Integer idUsuario) {
        Usuario usuario = usuarioRepository.findById(idUsuario)
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado."));
        return postagemRepository.findByUsuario(usuario);
    }
}
