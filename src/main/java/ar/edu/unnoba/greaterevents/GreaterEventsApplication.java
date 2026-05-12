package ar.edu.unnoba.greaterevents;

import java.util.TimeZone;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.SpringApplication;

@SpringBootApplication
public class GreaterEventsApplication {
	public static void main(String[] args) {
		TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
		SpringApplication.run(GreaterEventsApplication.class, args);
	}
}
