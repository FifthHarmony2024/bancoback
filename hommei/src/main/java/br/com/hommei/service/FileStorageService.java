package br.com.hommei.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Service
@Slf4j
public class FileStorageService {

    @Value("${file.upload-dir}") // Injetar a propriedade configurada
    private String uploadDir;

    public String saveFile(MultipartFile file) throws IOException {
        // Gera um nome único para o arquivo
        String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();

        // Define o caminho completo
        Path filePath = Paths.get(uploadDir, fileName);

        // Cria o diretório, se necessário
        Files.createDirectories(filePath.getParent());

        // Salva o arquivo
        Files.write(filePath, file.getBytes());

        log.info("Arquivo salvo em: {}", filePath.toString());

        // Retorna o caminho salvo
        return filePath.toString();
    }
}
