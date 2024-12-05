
package br.com.hommei.dto;

import br.com.hommei.enuns.RoleEnum;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class LoginRequestDTO {

    private String emailLogin;
    private String senha;
    private RoleEnum roleEnum;

}

