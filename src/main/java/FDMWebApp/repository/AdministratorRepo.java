package FDMWebApp.repository;

import FDMWebApp.domain.Administrator;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by Dani on 02/03/2017.
 */
@Repository
public interface AdministratorRepo extends PagingAndSortingRepository<Administrator, Long> {
	Administrator findById(long id);

	Administrator findByUsername(String username);

	Page<Administrator> findAll(Pageable pageable);
}
