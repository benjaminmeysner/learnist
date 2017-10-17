package FDMWebApp.repository;

import FDMWebApp.domain.SupportingFile;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by Rusty on 25/04/2017.
 */
@Repository
public interface FileRepo extends CrudRepository<SupportingFile, Long> {

	public SupportingFile findByUrl(String url);
}
