package FDMWebApp.repository;

import FDMWebApp.domain.Address;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by Dani on 24/02/17.
 */
@Repository
public interface AddressRepo extends CrudRepository<Address, Long> {
	Address findById(long id);

	@Query(value = "SELECT * FROM address a where a.country = :country AND "
			+ "a.`street-address` = :street AND a.`postal-code` = :post", nativeQuery = true)
	Address findByCountryAndStreet_AddressAndPostalCode(@Param("country") String country,
	                                                    @Param("street") String street, @Param("post") String post);
}
