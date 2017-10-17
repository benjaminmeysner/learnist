package FDMWebApp.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Dani on 21/02/17.
 */

@Entity
@Table(name = "address")
public class Address {

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE)
	@Column(name = "`id`")
	private long id;

	@Column(name = "`country`")
	private String country;

	@Column(name = "`postal-code`")
	private String postalcode;

	@Column(name = "`street-address`")
	private String street_address;

	public Address() {

	}

	public Address(String country, String postalcode, String street_address) {
		this.country = country;
		this.postalcode = postalcode;
		this.street_address = street_address;
	}

	public static boolean isAddressAcceptable(Address address) {
		// in case its null
		if (address == null)
			return true;
		// in case it is not valid
		return ((!address.getCountry().isEmpty() && !address.getPostalcode().isEmpty()
				&& !address.getStreet_address().isEmpty())
				|| (address.getCountry().isEmpty() && address.getPostalcode().isEmpty()
				&& address.getStreet_address().isEmpty())

		);

	}

	public static boolean isEmpty(Address address) {
		return (address.getCountry().isEmpty() && address.getPostalcode().isEmpty()
				&& address.getStreet_address().isEmpty());
	}

	public static boolean isNull(Address address) {
		return ((address.getStreet_address() == null) && (address.getPostalcode() == null)
				&& (address.getCountry() == null));
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country.toLowerCase();
	}

	public String getPostalcode() {
		return postalcode;
	}

	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode.toLowerCase();
	}

	public String getStreet_address() {
		return street_address;
	}

	public void setStreet_address(String street_address) {
		this.street_address = street_address.toLowerCase();
	}


	@Override
	public String toString() {
		return "Address{" + "id=" + id + "\n country='" + country + '\'' + "\n postalcode='" + postalcode + '\''
				+ "\n street_address='" + street_address + '\'' + '}';
	}
}
