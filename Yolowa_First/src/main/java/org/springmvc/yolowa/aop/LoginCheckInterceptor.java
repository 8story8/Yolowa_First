package org.springmvc.yolowa.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/*Spring Handler Interceptor : 
DispatcherServlet이 해당 컨트롤러를 호출하기 전,후에 요청과 응답을
제어하는 역할을 한다. 
 
컨트롤러 실행전  preHandle(request,response,handler) 
컨트롤러 실행후 postHandle(request,response,handler)
응답완료 afterCompletion(request,response,handler)
Spring에서 제공하는 HandlerInterceptorAdapter 를 상속받아 
위와 같은 메서드를 오버라이딩해서 사용한다

DispatcherServlet		--		HandlerInterceptor		-- Handler(Controller)
											컨트롤러 영역의		
												공통관심사항을 일괄 처리
											로그인 인증여부를 체크해서 로그인되어 있지 않은 사용자의 요청은
											요청에 해당하는 핸들러(컨트롤러)를 실행하지 않고
											index로 redirect 시킨다.

*/
public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

	/**
	 * 해당 Controller 수행전에 실행(제어)되는 메서드 preHandle 메서드에서 true를 반환하면 기존 컨트롤러가 실행하고
	 * false를 반환하면 기존 Controller는 실행되지 않는다.
	 * 
	 * 인증여부 확인하여 인증되어 있으면 true를 반환 인증되어 있지 않으면 index로 리다렉트 후 false를 반환
	 */

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession(false);
		System.out.println("Handler Interceptor 실행" + request.getRequestURI());

		if (session != null && session.getAttribute("member") != null) {
			return true;
		} else {
			response.sendRedirect("home.do");
			return false;
		}
	}

}
