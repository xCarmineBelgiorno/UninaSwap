package com.utility;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// Inizializzazione del filtro
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession(false);
		
		String requestURI = httpRequest.getRequestURI();
		// Logging minimale per debugging
		System.out.println("[AuthFilter] URI: " + requestURI);
		
		// Risorse pubbliche che NON richiedono login
		boolean isPublic =
			requestURI.endsWith("/") ||
			requestURI.endsWith("index.jsp") ||
			requestURI.endsWith("customerlogin.jsp") ||
			requestURI.endsWith("customer_reg.jsp") ||
			requestURI.endsWith("login") ||
			requestURI.endsWith("register") ||
			requestURI.endsWith("logout") ||
			requestURI.endsWith("testdb") ||
			requestURI.endsWith("simplelogin") ||
			requestURI.contains("/Css/") ||
			requestURI.contains("/images/") ||
			requestURI.endsWith(".css") ||
			requestURI.endsWith(".js") ||
			requestURI.endsWith(".png") ||
			requestURI.endsWith(".jpg") ||
			requestURI.endsWith(".webp");
		
		if (isPublic) {
			chain.doFilter(request, response);
			return;
		}
		
		// Controlla se l'utente è loggato
		boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
		
		if (!isLoggedIn) {
			// Reindirizza alla pagina di login
			httpResponse.sendRedirect(httpRequest.getContextPath() + "/customerlogin.jsp");
			return;
		}
		
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		// Cleanup del filtro
	}
}