package com.oracle.samil;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories
public class SamilApplication {

	public static void main(String[] args) {
		SpringApplication.run(SamilApplication.class, args);
	}

}
