// Decompiled by DJ v3.12.12.98 Copyright 2014 Atanas Neshkov  Date: 2018/7/12 14:57:38
// Home Page:  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) ansi 
// Source File Name:   upload.java

package com.workplan.tools;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
* 类名称：FileUtils   
* 类描述：  上传文件工具类 
* @version V1.0  
*
 */
public class UploadPicUtil {
	/**
	 * 
	* @Title: uploadFile 
	* @Description: TODO(上传文件) 
	* @param @param request
	* @param @param path
	* @param @return    
	* @return Map<String,Object>    返回类型 
	* @throws
	 */
	public static Map<String, Object> uploadFile(HttpServletRequest request,
			String path,String project_code) {//,String project_progress

		// 获得磁盘文件条目工厂
		DiskFileItemFactory factory = new DiskFileItemFactory();
		creatFile(path);
		// 如果没以下两行设置的话，上传大的文件会占用很多内存，
		// 设置暂时存放的存储室 ,这个存储室,可以和最终存储文件的目录不同
		/**
		 * 原理 它是先存到 暂时存储室，然后在真正写到 对应目录的硬盘上， 按理来说 当上传一个文件时，其实是上传了两份，第一个是以 .tmp
		 * 格式的 然后再将其真正写到 对应目录的硬盘上
		 */
		factory.setRepository(new File(path));
		// 设置 缓存的大小，当上传文件的容量超过该缓存时，直接放到 暂时存储室
		factory.setSizeThreshold(1024 * 1024);//kb

		// 高水平的API文件上传处理
		ServletFileUpload upload = new ServletFileUpload(factory);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		try {
			// 提交上来的信息都在这个list里面
			// 这意味着可以上传多个文件
			// 请自行组织代码
			List<FileItem> list = upload.parseRequest(request);
			System.out.println("上传的list,size()="+list.size());
			
			// 获取上传的文件
			FileItem item = getUploadFileItem(list);
			String filename = getUploadFileName(item);
			Map<String, String> splitFile = splitFile(filename);
			System.out.println("文件名:" + splitFile.get("name"));
			int count=1;
			for (int i = 0; i < count; i++,count++) {
				System.out.println("count="+count+",i="+i);
				filename=project_code+"_"+count+"_"+splitFile.get("name")+splitFile.get("format");//+project_progress+"_"
				if(!judeFileExists(path+"\\"+filename))
					break;
				if(count==9999){
					System.out.println("文件名重命名循环序列运行达到9999次，自动停止");
					break;
				}
			}
			System.out.println("修改为："+filename);
			System.out.println("存放目录:" + path);
			System.out.println("文件名:" + filename);
			// 真正写到磁盘上
			item.write(new File(path, filename)); // 第三方提供的
			returnMap.put("state", true);
			returnMap.put("filename", filename);
			returnMap.put("splitFile", splitFile.get("format"));
		} catch (FileUploadException e) {
			returnMap.put("state", false);
		} catch (Exception e) {
			returnMap.put("state", false);
		}
		return returnMap;
	}
	
	/**
	 * 
	* @Description: TODO(拆分文件名) 
	* @param @param str
	* @param @return    name：文件名称 
	* @return Map<String,Object>    返回类型 
	* @throws
	 */
	public static Map<String, String> splitFile(String str) {
		String name=str.substring(0,str.lastIndexOf("."));
		String format=str.substring(str.lastIndexOf("."),str.length());
		Map<String, String> returnMap =new HashMap<String, String>();
		returnMap.put("name", name);
		returnMap.put("format", format);
		return returnMap;
	}

	/**
	 * 获取路径名
	 * @Title: getUploadFileName
	 * @Description: TODO( 获取路径名)
	 * @param @param item
	 * @param @return
	 * @return String 返回类型
	 * @throws
	 */
	private static String getUploadFileName(FileItem item) {
		// 获取路径名
		String value = item.getName();
		// 索引到最后一个反斜杠
		int start = value.lastIndexOf("/");
		// 截取 上传文件的 字符串名字，加1是 去掉反斜杠，
		String filename = value.substring(start + 1);

		return filename;
	}

	/**
	 * @Title: getUploadFileItem
	 * @Description: TODO(获取上传文件)
	 * @param @param list
	 * @param @return
	 * @return FileItem 返回类型
	 * @throws
	 */
	private static FileItem getUploadFileItem(List<FileItem> list) {
		for (FileItem fileItem : list) {
			if (!fileItem.isFormField()) {
				return fileItem;
			}
		}
		return null;
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
	 * 
	* @Title: judeFileExists 
	* @Description: TODO(判断文件是否存在) 
	* @param @param path
	* @param @return    
	* @return boolean    返回类型 
	* @throws
	 */
	public static boolean judeFileExists(String path) {
		System.out.println("judeFileExists："+path);
		File file = new File(path);
		if (file.exists()) {
			System.out.println("文件存在");
			//file.delete();
			//System.out.println("删除完成...");
			return true;
		} else {
			System.out.println("文件不存在");
			return false;
		}

	}
	
	/**
	* @Title: deleteFile 
	* @Description: TODO(删除单个文件) 
	* @param @param sPath
	* @param @return    
	* @return boolean    返回类型 
	* @throws
	 */
	public static boolean deleteFile(String path) {  
	    File file = new File(path);  
	    // 路径为文件且不为空则进行删除  
	    if (file.isFile() && file.exists()) {  
	        file.delete();  
	        return true;  
	    }  
	    return false;  
	}  
}