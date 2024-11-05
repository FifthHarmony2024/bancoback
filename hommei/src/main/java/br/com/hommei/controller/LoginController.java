
package br.com.hommei.controller;


import br.com.hommei.dto.LoginRequestDTO;
import br.com.hommei.dto.LoginResponseDTO;
import br.com.hommei.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private LoginService loginService;

    @PostMapping
    public ResponseEntity<LoginResponseDTO> autenticar(@RequestBody LoginRequestDTO request) {
        var token = loginService.autenticar(request);
        return ResponseEntity.ok(token);
    }

}

