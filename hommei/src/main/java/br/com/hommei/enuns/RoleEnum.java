package br.com.hommei.enuns;

import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public enum RoleEnum {
    CLIENTE,
    PRESTADOR,
    ADMINISTRADOR;

    private static final Map<String, RoleEnum> MAP_CONVERTER = Stream.of(RoleEnum.values())
                                                                     .collect(Collectors.toMap(RoleEnum::getValue,
                                                                                               Function.identity()));

    public String getValue() {
        return "ROLE_" + this.name();
    }

    public static RoleEnum getByValue(String value) {
        return MAP_CONVERTER.get(value);
    }
}
