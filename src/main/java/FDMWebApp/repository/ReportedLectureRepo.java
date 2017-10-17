package FDMWebApp.repository;

import FDMWebApp.domain.ReportedLecture;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by dani1 on 30/04/2017.
 */
@Repository
public interface ReportedLectureRepo extends CrudRepository<ReportedLecture, Long> {
}
