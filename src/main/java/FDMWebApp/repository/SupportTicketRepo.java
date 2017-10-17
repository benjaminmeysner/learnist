package FDMWebApp.repository;

import FDMWebApp.domain.SupportTicket;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by dani1 on 18/04/2017.
 */
@Repository
public interface SupportTicketRepo extends CrudRepository<SupportTicket, Long> {

	@Query(value = "select t.* from ((ticket t inner join user_support_tickets ust on ust.support_tickets_id = t.id)" +
			" inner join  user u on ust.user_id = u.id and u.id = ?1)", nativeQuery = true)
	List<SupportTicket> getSupportTicketOfUserByUserId(long id);
}