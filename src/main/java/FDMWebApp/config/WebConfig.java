/**
 * Created by Rusty on 16/02/2017.
 */
package FDMWebApp.config;

import FDMWebApp.auth.CustomAuthenticationHandler;
import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.boot.web.servlet.ErrorPage;
import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import java.util.Properties;

@Configuration
@EnableWebMvc
public class WebConfig extends WebMvcConfigurerAdapter {

	// Handles HTTP GET requests for /resources/** by efficiently serving up
	// static
	// resources in the ${webappRoot}/resources/ directory
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/META-INF/**").addResourceLocations("/resources/");
	}

	@Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**");
	}

	// Java configuration equivalent to
	// <mvc:default-servlet-handler/> in spring-servlet.xml
	// used to use bootstrap when security is enabled
	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}

	// Resolves views selected for rendering by @Controllers to .jsp resources
	// in the
	// /WEB-INF/views directory
	@Bean
	public InternalResourceViewResolver viewResolver() {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setViewClass(JstlView.class);
		viewResolver.setPrefix("/WEB-INF/jsp/");
		viewResolver.setSuffix(".jsp");
		viewResolver.setOrder(2);
		return viewResolver;
	}

	@Bean
	public SimpleMappingExceptionResolver simpleMappingExceptionResolver() {
		SimpleMappingExceptionResolver b = new SimpleMappingExceptionResolver();
		Properties mappings = new Properties();
		mappings.put("FDMWebApp.controller.error.SpringException", "error/exception");
		mappings.put("defaultErrorView", "error/exception");
		b.setExceptionMappings(mappings);
		return b;
	}

	@Bean
	public EmbeddedServletContainerCustomizer containerCustomizer() {
		return new EmbeddedServletContainerCustomizer() {
			@Override
			public void customize(ConfigurableEmbeddedServletContainer container) {
				container.addErrorPages(new ErrorPage(HttpStatus.BAD_REQUEST, "/404"));
				container.addErrorPages(new ErrorPage(HttpStatus.NOT_FOUND, "/404"));
				container.addErrorPages(new ErrorPage(HttpStatus.REQUEST_TIMEOUT, "/404"));
			}
		};
	}

	@Bean
	public CustomAuthenticationHandler customAuthenticationHandler() {
		return new CustomAuthenticationHandler();
	}

	@Bean
	public ServletContextInitializer initializer() {
		return new ServletContextInitializer() {

			@Override
			public void onStartup(ServletContext servletContext) throws ServletException {
				servletContext.setAttribute("environment", System.getProperty("name"));
			}
		};
	}
}
