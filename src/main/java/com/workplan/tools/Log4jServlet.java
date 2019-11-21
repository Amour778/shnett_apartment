package com.workplan.tools;

import org.apache.log4j.PropertyConfigurator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

/**
 * 日志
 * @author 01059101
 *
 */
public class Log4jServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;

	@Override
	public void destroy() {
		super.destroy();
	}

	public Log4jServlet() {
		super();
	}

	@Override
	public void init() throws ServletException {
		String file = this.getInitParameter("log4j");// 从web.xml配置读取，名字一定要和web.xml配置一致
		if (file != null) {
			PropertyConfigurator.configure(file);
		}
	}

}