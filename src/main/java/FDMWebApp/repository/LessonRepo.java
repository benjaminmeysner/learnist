package FDMWebApp.repository;

import FDMWebApp.domain.Course;
import FDMWebApp.domain.Lesson;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by Rusty on 25/04/2017.
 */
@Repository
public interface LessonRepo extends PagingAndSortingRepository<Lesson, Long> {

	Lesson findByCourseAndOrder(Course course, int id);

	Page<Lesson> findByCourse(Course course, Pageable pageable);

}
