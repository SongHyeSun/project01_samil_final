package com.oracle.samil.Acontroller;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // MyInterceptor를 WebRequestHandlerInterceptorAdapter로 감싸서 등록
        registry.addInterceptor(new MyInterceptor())
                .addPathPatterns("/login") 
        		.addPathPatterns("*/check");  
    }
}