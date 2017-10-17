package FDMWebApp.repository;

import FDMWebApp.domain.Course;
import FDMWebApp.domain.Learner;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Dani on 02/03/2017.
 */
@Repository
public interface LearnerRepo extends PagingAndSortingRepository<Learner, Long> {
	Learner findById(long id);

	Learner findByUsername(String username);

	Learner findByEmail(String email);

	List<Learner> findByCoursesInOrderByUsername(List<Course> course);

	Page<Learner> findAllByActivated(Boolean activated, Pageable pageable);

	Page<Learner> findByCoursesInOrderByUsername(List<Course> courses, Pageable pageable);

	int countByActivated(Boolean activated);

	int countByEmail(String email);

	int countByUsername(String username);
}
