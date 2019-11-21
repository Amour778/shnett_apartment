package com.workplan.tools;

import org.apache.commons.lang3.StringUtils;

public class GeneratePasswordUtil {
	/**
	 * 随机生成6位密码
	 * 
	 * @return
	 */
	public static String generatePassword() {
		String[] pa = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
				"l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w",
				"x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I",
				"J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
				"V", "W", "X", "Y", "Z" };
		StringBuffer sb = new StringBuffer("");
		for (int i = 0; i < 6; i++) {
			sb.append(pa[(Double.valueOf(Math.random() * pa.length).intValue())]);
		}
		String[] spe = { "`", "~", "!", "@", "#", "$", "%", "^", "&", "*", "(",
				")", "-", "_", "=", "+", "[", "]", "{", "}", "\\", "/", "?",
				",", ".", "<", ">" };
		sb.append(spe[(Double.valueOf(Math.random() * spe.length).intValue())]);
		sb.append((int) (Math.random() * 100));
		return sb.toString();
	}

	/**
	 * 校验密码 1、长度不小于6位 2、必须以字母开头 3、必须包含特殊字符 4、必须包含数字
	 * 
	 * @param pwd
	 * @return
	 */
	public static boolean validPwd(String pwd) {
		if (StringUtils.isEmpty(pwd)) {
			return false;
		}
		if (pwd.length() < 6) {
			return false;
		}
		if (pwd.matches("^[a-zA-z](.*)")//2
				&& pwd.matches("(.*)[-`=\\\\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]+(.*)")//3
				&& pwd.matches("(.*)\\d+(.*)")) {//4
			return true;
		}
		return false;
	}

	
}
