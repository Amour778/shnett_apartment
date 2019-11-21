package com.workplan.tools;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;


public class uploadUserInfo {
	public String upload(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
	    int fail = 0;
	    ArrayList<String> message = new ArrayList<String>();
	    String responseString = null;
/*
	    InputStream is = null;
	    String savePath = request.getSession().getServletContext().getRealPath("WEB-INF/Files_Upload");
	    System.out.println(savePath);
	    File saveFileDir = new File(savePath);
	    if (!(saveFileDir.exists()))
	    {
	      saveFileDir.mkdirs();
	    }

	    String tmpPath = request.getSession().getServletContext().getRealPath("WEB-INF/Files_Upload/temp");
	    File tmpFile = new File(tmpPath);
	    if (!(tmpFile.exists()))
	    {
	      tmpFile.mkdirs();
	    }
	    HttpSession session = request.getSession();
	      try {
	        DiskFileItemFactory factory = new DiskFileItemFactory();
	        factory.setSizeThreshold(10240);
	        factory.setRepository(tmpFile);
	        ServletFileUpload upload = new ServletFileUpload(factory);
	        //upload.setProgressListener(new ProgressListener(){
	        //	public void update(long readedBytes, long totalBytes, int currentItem){
	        //  }
	        //});
	        upload.setHeaderEncoding("UTF-8");
	        if (!(ServletFileUpload.isMultipartContent(request)))
	        {
	        	responseString="{\"code\":1,\"info\":\"\"未知错误\"}";
	        }
	        List<FileItem> items = upload.parseRequest(request);
	        Iterator<FileItem> itr = items.iterator();

	        String saveFileName = null;

	        while (itr.hasNext()) {
	          FileItem item = itr.next();
	          String value;
	          if (item.isFormField()) {
	            String name = item.getFieldName();

	            value = item.getString("UTF-8");
	          }
	          else
	          {
	            String fileName = item.getName();
	            if ((fileName == null) && (fileName.trim().length() == 0))
	            {
	              continue;
	            }

	            fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);

	            String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

	            String TIME = Com_id();
	            saveFileName = fileName + TIME;

	            InputStream in = item.getInputStream();

	            FileOutputStream out = new FileOutputStream(savePath + "\\" + saveFileName);

	            byte[] buffer = new byte[1024];

	            int len = 0;
	            while ((len = in.read(buffer)) > 0) {
	              out.write(buffer, 0, len);
	            }

	            out.close();

	            in.close();

	            item.delete();
	          }
	        }

	        String filepath = "/WEB-INF/Files_Upload/" + saveFileName;
	        
	        filepath = request.getSession().getServletContext().getRealPath(filepath);
	        try
	        {
	          is = new FileInputStream(filepath);

	          Workbook wb = Workbook.getWorkbook(is);
	          System.out.println("创建工作簿完成");

	          Sheet sheet = wb.getSheet(0);
	          System.out.println("创建工作表完成");

	          int add_success = 0;
	          int add_fail = 0;

	          System.out.println("sheet.getRows()=" + sheet.getRows());

	          if (!(sheet.getCell(0, 0).getContents().equals("用户工号"))) {
	            responseString = "{\"code\": 1,\"info\":\"导入的表格不正确\"}";
	          }else {
	              List<UserInfoBean> userlist=new ArrayList<UserInfoBean>();

            	  ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
            	  UserInfoDao dao = (UserInfoDao) context.getBean("UserInfoDao");
	              for (int i = 1; i < sheet.getRows(); i++)
	              {
	                if ((sheet.getCell(0, i).getContents().replaceAll(" ", "") == "") && 
	                  (sheet.getCell(1, i).getContents().replaceAll(" ", "") == "") && 
	                  (sheet.getCell(2, i).getContents().replaceAll(" ", "") == "")) {
	                  System.out.println("皆为空");
	                }else if ((sheet.getCell(0, i).getContents().replaceAll(" ", "") == "") || 
	                        (sheet.getCell(1, i).getContents().replaceAll(" ", "") == "") || 
	                        (sheet.getCell(2, i).getContents().replaceAll(" ", "") == "")){
	                        System.out.println("数据填写不全");
	                        message.add("\"第" + i + "行-数据填写不全<br/>\"");
	                        add_fail++;
	                }else if ((sheet.getCell(2, i).getContents().replaceAll(" ", "").length()!=11)){
                        System.out.println("手机号码填写错误");
                        message.add("\"第" + i + "行-手机号码填写错误<br/>\"");
                        add_fail++;
	                }else if (!(dao.queryAll(sheet.getCell(0, i).getContents().replaceAll(" ", "")).size()==0)){
	                    System.out.println("用户工号已存在");
	                    message.add("\"第" + i + "行-用户工号已存在<br/>\"");
	                    add_fail++;
                	}else{
		                  String user_id = sheet.getCell(0, i).getContents().replaceAll(" ", "");
		                  String user_password="da4b9237bacccdf19c0760cab7aec4a8359010b0";
		                  String user_name = sheet.getCell(1, i).getContents().replaceAll(" ", "");
		                  String user_tel = sheet.getCell(2, i).getContents().replaceAll(" ", "");
			        	  UserInfoBean ad = new UserInfoBean();
		                  ad.setUser_id(user_id);
		                  ad.setUser_password(user_password);
		                  ad.setUser_name(user_name);
		                  ad.setUser_tel(user_tel);
		                  userlist.add(ad);
		                  add_success++;
		                }
	              }
	              if(add_fail==0&&add_success!=0){
	                 
	                  dao.batchInsertUser(userlist);
	                  responseString = "{\"code\":  0,\"info\":\"数据上传成功\"}";
	              }else if(add_fail==0&&add_success==0){
	            	  responseString = "{\"code\":  1,\"info\":\"无数据\"}";
	      		}else {
	            	  responseString = "{\"code\":  1,\"info\":" + message + "}";
	    		}
	              is.close();
	              wb.close();
	            }
			}
	        catch (Exception e) {
	          message.add("\"" + e.getMessage() + "\"");
	          responseString="{\"code\": 1,\"info\":" + message + "}";
	        }
	      } catch (FileUploadBase.FileSizeLimitExceededException e) {
	          message.add("\"" + e.getMessage() + "\"");
	          responseString="{\"code\": 1,\"info\":" + message + "}";
	      } catch (FileUploadException e) {
	          message.add("\"" + e.getMessage() + "\"");
	          responseString="{\"code\": 1,\"info\":" + message + "}";
	      } catch (Exception e2) {
	          message.add("\"未知错误，excel数据貌似有问题:\"" + e2.getMessage()+"\"");
	          responseString="{\"code\": 1,\"info\":" + message + "}";
	      }
	    System.out.println("responseString=" + responseString);*/
		return responseString;
	}


	  public String Com_id()
	  {
	    int max = 9999;
	    int min = 1000;
	    Random random = new Random();
	    int s = random.nextInt(max) % (max - min + 1) + min;
	    SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
	    String date = df.format(new Date());
	    return date + s;
	  }
}
