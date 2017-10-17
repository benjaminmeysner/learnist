package FDMWebApp.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

@Configuration
public class DbConfig {

	@Bean
	public DriverManagerDataSource dataSource(Environment env) {

		String database = "fdm-" + System.getProperty("name");
		DriverManagerDataSource ds = new DriverManagerDataSource();
		ds.setDriverClassName(env.getProperty("spring.datasource.driver-class-name"));
		ds.setUrl("jdbc:mysql://" + env.getProperty("spring.datasource.url") + "/" + database);
		ds.setUsername(env.getProperty("spring.datasource.username"));
		ds.setPassword(env.getProperty("spring.datasource.password"));
		return ds;
	}

}
