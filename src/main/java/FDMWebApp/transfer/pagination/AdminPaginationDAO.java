package FDMWebApp.transfer.pagination;

/**
 * Created by Erustus on 07/04/2017.
 */
public class AdminPaginationDAO {

	public static final int SIZE = 5;

	private Pagination actives;
	private Pagination inactives;
	private Pagination application;

	public AdminPaginationDAO() {
		// for testing uses only
	}

	public AdminPaginationDAO(Pagination actives, Pagination inactives, Pagination application) {
		this.actives = actives;
		this.inactives = inactives;
		this.application = application;
	}

	public Pagination getActives() {
		return actives;
	}

	public void setActives(Pagination actives) {
		this.actives = actives;
	}

	public Pagination getInactives() {
		return inactives;
	}

	public void setInactives(Pagination inactives) {
		this.inactives = inactives;
	}

	public Pagination getApplication() {
		return application;
	}

	public void setApplication(Pagination application) {
		this.application = application;
	}

}