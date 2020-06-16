package org.yale.registry.research;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
@EntityScan(basePackages = "org.yale.registry.research.entities")
@EnableJpaRepositories("org.yale.registry.research.repositories")
@EnableAsync
public class ResearchApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(ResearchApplication.class, args);
    }

}
