package com.workplan.handler;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;


@Controller
public class TempletsHandler {
	
	/**
	 * 下载文件：服务器上不需要转码，本地需要转码
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping("/templetsDownLoadServlet")
	public void list(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		
	    String fileName = request.getParameter("filename");
	    System.out.println("转码前fileName=" + fileName);
	    //fileName = new String(fileName.getBytes("ISO8859-1"), "UTF-8");
	    //System.out.println("转码后fileName=" + fileName);
	    String fileSaveRootPath = request.getSession().getServletContext().getRealPath("/WEB-INF/templets");
	    String path = fileSaveRootPath + "\\" + fileName;
	    System.out.println("path=" + path);
	    File file = new File(path);
	    System.out.println("file=" + file);
	    System.out.println("file.exists()=" + file.exists());
	    if (!(file.exists())) {
	      String Message = "{\"msg\": \"文件不存在\"}";
	      response.getWriter().print(Message);
	      return ;
	    }
	    String realname = fileName.substring(fileName.indexOf("_") + 1);
	    System.out.println("realname=" + realname);
	    response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(realname, "UTF-8"));
	    //response.setHeader("content-disposition", "attachment;filename=" + realname);
	    FileInputStream in = new FileInputStream(path);
	    OutputStream out = response.getOutputStream();
	    byte[] buffer = new byte[1024];
	    int len = 0;
	    while ((len = in.read(buffer)) > 0)
	    {
	      out.write(buffer, 0, len);
	    }
	    in.close();
	    out.close();
	  }

	  public String findFileSavePathByFileName(String filename, String saveRootPath)
	  {
	    int hashcode = filename.hashCode();
	    int dir1 = hashcode & 0xF;
	    int dir2 = (hashcode & 0xF0) >> 4;
	    String dir = saveRootPath + "\\" + dir1 + "\\" + dir2;
	    File file = new File(dir);
	    if (!(file.exists()))
	    {
	      file.mkdirs();
	    }
	    return dir;
	  }

	  /**
	   * 列举文件夹下的文件
	   * @param request
	   * @param response
	   * @throws ServletException
	   * @throws IOException
	   */
	@RequestMapping("/templetsFilesListsServlet")
	public void templetsServlet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    response.setContentType("text/html;charset=utf-8");

    String uploadFilePath = request.getSession().getServletContext().getRealPath("/WEB-INF/templets");

    Map<String, String> fileNameMap = new HashMap<String, String>();

    listfile(new File(uploadFilePath), fileNameMap);
    String dataString = "";
    for (Iterator<String> localIterator = fileNameMap.keySet().iterator(); localIterator.hasNext(); ) { Object o = localIterator.next();
      System.out.println("{\"key\":\"name\",\"domnload_url\":" + (fileNameMap.get(o)) + "},");
      dataString = dataString + "{\"name\":\"" + (fileNameMap.get(o)) + "\",\"domnload_url\":\"" + (fileNameMap.get(o)) + "\"},";
    }
    dataString = "[" + dataString.substring(0, dataString.length() - 1) + "]";

    String Message = "{\"code\": \"0\",\"msg\": \"成功\",\"count\":\"" + fileNameMap.size() + "\",\"data\": " + dataString + "}";

    System.out.println(Message);
    response.getWriter().print(Message);
  }

  public void listfile(File file, Map<String, String> map)
  {
    if (!(file.isFile()))
    {
      File[] files = file.listFiles();

      for (File f : files)
      {
        listfile(f, map);
      }

    }
    else
    {
      String realName = file.getName().substring(file.getName().indexOf("_") + 1);
      map.put(file.getName(), realName);
    }
  }

}
