package FDMWebApp.repository;

import FDMWebApp.domain.User;
import FDMWebApp.domain.VerificationToken;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by Rusty on 06/03/2017.
 */
@Repository
public interface VerificationTokenRepo extends CrudRepository<VerificationToken, Long> {

	VerificationToken findByToken(String token);

	User findUserByToken(String token);

}
