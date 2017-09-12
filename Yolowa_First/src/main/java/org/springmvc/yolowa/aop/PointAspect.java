package org.springmvc.yolowa.aop;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;

import javax.annotation.Resource;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springmvc.yolowa.model.service.PointService;
import org.springmvc.yolowa.model.vo.MemberVO;

@Component
@Aspect
public class PointAspect {
	
	@Resource
	private PointService pointService;
	
	@Around("execution(public * org.springmvc.yolowa.model.service.*Service.user*(..))")
	public Object pointLog(ProceedingJoinPoint point) throws Throwable {
		String mn = point.getSignature().getName();
		String content = null;// 로그 내용
		int lPoint = 50;
		Object retValue = null;//login-id
		Object param[]=point.getArgs();//method인자값
		
		retValue = point.proceed();
		
		if(mn.equals("userLogin")){
			MemberVO mvo = (MemberVO) retValue;
			String day = null;
			day = pointService.getLogDateById(mvo.getId());
			content = "로그인 포인트";
			Calendar cal= Calendar.getInstance();
		    SimpleDateFormat today = new SimpleDateFormat("yyyy-MM-dd");
		    
		    if(!today.format(cal.getTime()).equals(day)){
		    	pointService.pointSave(mvo.getId());
		    	pointService.logData(content, lPoint, mvo.getId());
		    }
		} else if(mn.equals("userRequestAccept")){
			content = "친구추가 포인트";
			
			for(int i = 0; i<param.length; i++){
				pointService.pointSave(param[i].toString());
				pointService.logData(content, lPoint, param[i].toString());
			}
		} else if(mn.equals("userWriteContext")){
			content = "글작성 포인트";
			System.out.println("retValue: "+retValue);
			@SuppressWarnings("unchecked")
			Map<String,Object> list = (Map<String, Object>) param[0];
			
			pointService.pointSave(list.get("id").toString());
			pointService.logData(content, lPoint, list.get("id").toString());
		}
		
		return retValue;
	}
}
