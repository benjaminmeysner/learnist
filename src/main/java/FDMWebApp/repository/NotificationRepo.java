package FDMWebApp.repository;

import FDMWebApp.domain.Notification;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by Rusty on 29/04/2017.
 */
public interface NotificationRepo extends CrudRepository<Notification, Long> {

    Notification findById(long id);
}
