package com.workplan.tools;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import net.sf.json.JSONArray;

import java.util.List;

/**
 * JSON数据相关操作
 *
 * @author 01059101
 *
 */
public class GsonUtil {
	public static String List2Json(List<?> list) {
		JSONArray json = JSONArray.fromObject(list);
		return json.toString();
	}

	// 一条json数据
	public static <T> T parseJsonWithGson(String jsonData, Class<T> type) {
		Gson gson = new Gson();
		T result = gson.fromJson(jsonData, type);
		return result;
	}

	// 将Json数组解析成相应的映射对象列表
	public static <T> List<T> parseJsonArrayWithGson(String jsonData,
			Class<T> type) {
		Gson gson = new Gson();
		List<T> result = gson.fromJson(jsonData, new TypeToken<List<T>>() {
		}.getType());
		return result;
	}

}