package FDMWebApp.repository;

import FDMWebApp.domain.Tag;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Dan B on 28/02/17.
 */
@Repository
public interface TagRepo extends CrudRepository<Tag, Long> {

	Tag findById(long id);

	List<Tag> findAllByNameContaining(String name);

	String findByName(String name);

}
