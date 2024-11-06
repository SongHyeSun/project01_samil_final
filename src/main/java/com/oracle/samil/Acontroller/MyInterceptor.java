package com.oracle.samil.Acontroller;

import org.springframework.stereotype.Component;
import org.springframework.web.context.request.WebRequestInterceptor;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.handler.WebRequestHandlerInterceptorAdapter;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@Component
public class MyInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 인터셉터에서 empno를 로그로 확인
        String empno = request.getParameter("empno");
        String password = request.getParameter("password");
        String salNum = request.getParameter("salNum");
        System.out.println("Interceptor - empno: " + empno);
        System.out.println("Interceptor - password: " + password);
        System.out.println("Interceptor - salNum: " + salNum);
        
        // 데이터 가공 또는 다른 처리를 수행
        return true; // Controller로 계속 요청 전달
    }
    
    
}
