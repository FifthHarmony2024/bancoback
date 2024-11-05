package br.com.hommei.service;

import br.com.hommei.dto.UsuarioAutenticadoDTO;
import br.com.hommei.mapper.ModelMapperCustom;
import br.com.hommei.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private ModelMapperCustom modelMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        var usuario = usuarioRepository.findByEmailLogin(username);
        if (usuario.isEmpty())
            throw new UsernameNotFoundException("usuario não encontrado");
        return modelMapper.map(usuario.get(), UsuarioAutenticadoDTO.class);

    }

}
