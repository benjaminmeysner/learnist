package FDMWebApp;

import FDMWebApp.repository.LearnerRepo;
import FDMWebApp.repository.AdministratorRepo;
import FDMWebApp.domain.Administrator;
import FDMWebApp.domain.Status;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application implements CommandLineRunner {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

	@Autowired
	AdministratorRepo administratorRepo;

	@Override
	public void run(String... args) throws Exception {

/*	Administrator administrator = new Administrator();
	administrator.setUsername("admin1");
	administrator.setEmail("rustygutu@gmail.com");
	administrator.setPassword(BCrypt.hashpw("123456",BCrypt.gensalt()));
	administrator.setAccessLevel(0);
	administrator.setStatus(Status.Verified);
	administrator.setBarcode();
	administratorRepo.save(administrator);*/

	}
}