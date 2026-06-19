package ar.edu.unnoba.greaterevents.notificationservice.utils;

import ar.edu.unnoba.greaterevents.notificationservice.dtos.message.EventStatusChange;
import ar.edu.unnoba.greaterevents.notificationservice.models.event.State;
import ar.edu.unnoba.greaterevents.notificationservice.services.NotificationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class NotificationRabbitListener {
    private final NotificationService notificationService;

    // Método que escucha los mensajes de cambio de estado de eventos
    @RabbitListener(queues = "notification.queue")
    public void handleEventStatusChange(EventStatusChange message) {
        log.info("Received event status change message: {}", message);
        
        State previous = State.valueOf(message.previousState());
        State current = State.valueOf(message.currentState());

        notificationService.processEventStatusChange(message.eventId(), previous, current);
    }
}
