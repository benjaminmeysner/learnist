package FDMWebApp.transfer.pagination;

import org.springframework.data.domain.Page;

/**
 * Created by erustus on 09/04/17.
 */
public class Pagination {

	public static final int SIZE = 5;

	private String url;
	private Page page;

	public Pagination() {

	}

	public Pagination(String url, Page page) {
		this.url = url;
		this.page = page;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

}
