package ar.edu.unnoba.greaterevents.catalogeventservice.configuration;

import org.springframework.amqp.core.TopicExchange;
import org.springframework.amqp.support.converter.JacksonJsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMQConfig {
    public static final String EXCHANGE_NAME = "event.exchange";
    public static final String ROUTING_KEY = "event.status.changed";

    @Bean
    TopicExchange eventExchange() {
        return new TopicExchange(EXCHANGE_NAME);
    }

    @Bean
    MessageConverter jsonMessageConverter() {
        return new JacksonJsonMessageConverter();
    }
}
