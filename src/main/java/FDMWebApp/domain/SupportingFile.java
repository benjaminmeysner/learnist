package FDMWebApp.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Rusty on 24/04/2017.
 */
@Entity
@Table(name = "file")
public class SupportingFile {

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE)
	@Column(name = "`id`")
	private long id;

	@Column(name = "`url`")
	private String url;

	public SupportingFile() {

	}

	public SupportingFile(String url) {
		this.url = url;
	}

	public long getId() {
		return id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getFilename() {
		int i = url.lastIndexOf('/');
		if (i > 0) {
			return url.substring(i + 1);
		} else {
			return "";
		}
	}

}
