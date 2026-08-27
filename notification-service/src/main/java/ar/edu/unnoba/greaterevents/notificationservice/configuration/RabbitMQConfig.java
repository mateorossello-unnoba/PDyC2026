package ar.edu.unnoba.greaterevents.notificationservice.configuration;

import org.springframework.amqp.core.*;
import org.springframework.amqp.support.converter.JacksonJsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Configuración de RabbitMQ para la comunicación entre servicios.
 */

@Configuration
public class RabbitMQConfig {
    public static final String EXCHANGE_NAME = "event.exchange";
    public static final String QUEUE_NAME = "notification.queue";
    public static final String ROUTING_KEY = "event.status.changed";

    @Bean
    Queue notificationQueue() {
        // Crear una cola para recibir notificaciones de cambios de estado de eventos de manera duradera.
        return new Queue(QUEUE_NAME, true);
    }

    @Bean
    TopicExchange eventExchange() {
        // Crear un exchange de tipo topic para cambios de estado de eventos.
        return new TopicExchange(EXCHANGE_NAME);
    }

    @Bean
    Binding binding(Queue notificationQueue, TopicExchange eventExchange) {
        // Establecer la relación entre la cola y el exchange con una clave de enrutamiento específica.
        return BindingBuilder.bind(notificationQueue).to(eventExchange).with(ROUTING_KEY);
    }

    @Bean
    MessageConverter jsonMessageConverter() {
        // Configurar un convertidor de mensajes para convertir objetos Java a JSON y viceversa.
        return new JacksonJsonMessageConverter();
    }
}
