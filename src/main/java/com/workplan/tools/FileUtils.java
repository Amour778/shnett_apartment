package com.workplan.tools;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

public class FileUtils {
	static int countFiles = 0;// 声明统计文件个数的变量
	static int countFolders = 0;// 声明统计文件夹的变量

	/**
	 * 
	 * @param request
	 * @param response
	 * @param filePath 例如弱电项目上传的文件路径为：WCP_Files_Upload
	 * @param keyword 关键字，用于搜索符合条件的文件
	 * @return
	 */
	public List<String> searchFilesReturnList(HttpServletRequest request, HttpServletResponse response,String filePath,String keyword) {
		// TODO Auto-generated method stub
		String uploadFilePath = request.getSession().getServletContext().getRealPath("/WEB-INF/"+filePath);
		File folder = new File(uploadFilePath);
		creatFile(uploadFilePath);
		List<String> result = searchFileTiList(folder, keyword);// 调用方法获得文件数组
		System.out.println("在 " + folder + " 以及所有子文件时查找对象" + keyword);
		System.out.println("查找了" + countFiles + " 个文件，" + countFolders
				+ " 个文件夹，共找到 " + result.size() + " 个符合条件的文件：");
		for (int i = 0; i < result.size(); i++) {// 循环显示文件
			System.out.println(result.get(i));// 显示文件绝对路径
        }
		return result;
	}
	
	/**
	 * @Title: creatFile
	 * @Description: TODO(创建文件夹)
	 * @param @param path
	 * @return void 返回类型
	 * @throws
	 */
	public static void creatFile(String path) {
		File file = new File(path);
		// 如果文件夹不存在则创建
		if (!file.exists() && !file.isDirectory()) {
			//System.out.println("//目录"+path+"不存在");
			file.mkdir();
		} else {
			//System.out.println("//目录"+path+"存在");
		}
	}

	/**
	 * 递归查找包含关键字的文件：方法中注释了该目录下文件夹中文件的查找
	 * @param folder
	 * @param keyWord
	 * @return
	 */
	public static  List<String> searchFileTiList(File folder, final String keyWord) {// 递归查找包含关键字的文件
		File[] subFolders = folder.listFiles(new FileFilter() {// 运用内部匿名类获得文件
					public boolean accept(File pathname) {// 实现FileFilter类的accept方法
						if (pathname.isFile()){// 如果是文件
							countFiles++;
						}else{
							// 如果是目录
							countFolders++;
						}
						if (pathname.isDirectory()
								|| (pathname.isFile() && pathname.getName()
										.toLowerCase().contains(
												keyWord.toLowerCase())))// 目录或文件包含关键字
							return true;
						return false;
					}
				});

		List<String> result = new ArrayList<String>();// 声明一个集合
		for (int i = 0; i < subFolders.length; i++) {// 循环显示文件夹或文件
			if (subFolders[i].isFile()) {// 如果是文件则将文件添加到结果列表中
				result.add(subFolders[i].getName());
			}
			/*
			 else {// 如果是文件夹，则递归调用本方法，然后把所有的文件加到结果列表中
					File[] foldResult = searchFile(subFolders[i], keyWord);
					for (int j = 0; j < foldResult.length; j++) {// 循环显示文件
						result.add(foldResult[j]);// 文件保存到集合中
					}
				}
			*/
		}
		return result;
	}
	
	/**
	 * 文件下载通用类：是否转码则需要看服务器是否获取到乱码
	 * @param request
	 * @param response
	 * @param FilePath 文件目录:例如弱电项目文件上传的目录WCP_Files_Upload
	 * @throws ServletException
	 * @throws IOException
	 */
	public void downLoadFile(HttpServletRequest request, HttpServletResponse response,String FilePath)throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
	    String fileName = request.getParameter("filename");
	    System.out.println("转码前fileName=" + fileName);
	    //fileName = new String(fileName.getBytes("ISO8859-1"), "UTF-8");
	    //System.out.println("转码后fileName=" + fileName);
	    String fileSaveRootPath = request.getSession().getServletContext().getRealPath("/WEB-INF/"+FilePath);
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
	    response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
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
}
