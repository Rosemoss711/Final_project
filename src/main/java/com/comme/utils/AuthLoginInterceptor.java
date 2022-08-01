package com.comme.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class AuthLoginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		if(request.getSession().getAttribute("loginSession") == null){
			response.sendRedirect("/");
			return false;
		}
		return true;
	}
}
