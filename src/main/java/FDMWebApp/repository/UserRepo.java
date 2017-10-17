package FDMWebApp.repository;

import FDMWebApp.domain.Status;
import FDMWebApp.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Dani on 02/03/2017.
 */
@Repository
public interface UserRepo extends PagingAndSortingRepository<User, Long> {
	User findById(long id);

	User findByUsername(String username);

	User findByEmail(String email);

	@Query("SELECT u from User u where u.username = ?1 or u.email = ?1")
	User findByUsernameOrEmail(String username);

	Page<User> findByUsernameContainingAndRoleContainingAndStatusInOrderByUsernameDesc(String username, String role,
	                                                                                   List<Status> status, Pageable pageable);

	Page<User> findByUsernameContainingAndRoleContainingAndStatusInAndActivatedOrderByUsernameDesc(String username,
	                                                                                               String role, List<Status> status, Boolean activated, Pageable pageable);

	List<User> findByUsernameContainingAndRoleContainingAndStatusIn(String username, String role, List<Status> status);

	List<User> findByUsernameContainingAndRoleContainingAndStatusInAndActivated(String username, String role,
	                                                                            List<Status> status, Boolean activated);

	@Query("SELECT CASE WHEN COUNT(u) > 0 THEN 'true' ELSE 'false' END FROM User u WHERE u.username = ?1")
	Boolean existsByUsername(String username);

	@Query("SELECT CASE WHEN COUNT(u) > 0 THEN 'true' ELSE 'false' END FROM User u WHERE u.email = ?1")
	Boolean existsByEmail(String email);

	@Query("SELECT CASE WHEN COUNT(u) > 0 THEN 'true' ELSE 'false' END FROM User u WHERE u.email = ?1 OR  u.username "
			+ "= ?2")
	Boolean existsByEmailOrUsername(String email, String username);

}
