package FDMWebApp.repository;

import FDMWebApp.domain.Lecturer;
import FDMWebApp.domain.Status;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by Dani on 02/03/2017.
 */
@Repository
public interface LecturerRepo extends PagingAndSortingRepository<Lecturer, Long> {
	Lecturer findById(long id);

	Lecturer findByUsername(String username);

	Lecturer findByEmail(String email);

	Page<Lecturer> findAllByStatus(Status status, Pageable pageable);

	Page<Lecturer> findAllByActivated(Boolean activated, Pageable pageable);

	int countByActivated(Boolean activated);

	int countByStatus(Status status);

	int countByEmail(String email);

	int countByUsername(String username);
}
