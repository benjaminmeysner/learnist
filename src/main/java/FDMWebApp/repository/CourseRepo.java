package FDMWebApp.repository;

import FDMWebApp.domain.Course;
import FDMWebApp.domain.Status;
import FDMWebApp.domain.Tag;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Dan B on 28/02/17.
 */
@Repository
public interface CourseRepo extends PagingAndSortingRepository<Course, Long> {
	Course findById(long id);


	List<Course> findTop3ByStatusOrderByRatingDesc(Status status);

	@Query(value = "SELECT *, " +
			"(SELECT COUNT(*) FROM course_learners cl " +
			"WHERE course.id = cl.id) " +
			"AS total " +
			"FROM course " +
			"WHERE course.status = :status " +
			"ORDER BY total DESC " +
			"LIMIT 3", nativeQuery = true)
	List<Course> getPopularCourses(@Param("status") String status);


	Page<Course> findAllByStatus(Status status, Pageable pageable);

	Page<Course> findAllByStatusOrderByRatingDesc(Status status, Pageable pageable);

	Page<Course> findAllByStatusAndNameContainingOrSubjectContainingOrTagsInOrderByRatingDesc(Status status, String name, String subject, List<Tag> tags, Pageable pageable);

	int countByStatus(Status status);

	Page<Course> findAllByStatusAndNameContainingOrSubjectContainingOrderByRatingDesc(Status status, String name, String subject, Pageable pageable);

	List<Course> findAllByStatusAndNameContainingOrSubjectContainingOrTagsInOrderByRatingDesc(Status status, String name, String subject, List<Tag> tags);

	List<Course> findAllByStatusInAndNameContainingAndSubjectContainingAndTagsIn(List<Status> statuses, String name, String subject, List<Tag> tags);

	Page<Course> findAllByStatusInAndNameContainingAndSubjectContainingAndTagsInOrderByRatingDesc(List<Status> status, String name, String subject, List<Tag> tags, Pageable pageable);
}
