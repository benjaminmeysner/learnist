package FDMWebApp.repository;

import FDMWebApp.domain.Review;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by Rusty on 30/04/2017.
 */
public interface ReviewRepo extends CrudRepository<Review, Long> {

}
