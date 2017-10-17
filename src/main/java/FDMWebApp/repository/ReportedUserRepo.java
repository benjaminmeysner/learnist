package FDMWebApp.repository;

import FDMWebApp.domain.ReportedUser;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by dani1 on 30/04/2017.
 */
@Repository
public interface ReportedUserRepo extends CrudRepository<ReportedUser, Long> {
}
