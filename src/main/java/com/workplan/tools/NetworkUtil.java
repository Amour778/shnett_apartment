package com.workplan.tools;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.regex.Pattern;

/**
 * MAC地址标准化
 * 
 * @author 01059101
 * 
 */
public class NetworkUtil {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println(macToMAC("48:5D:60:61:3D:C5"));
		System.out.println(macToMAC("48-5D-60-61-3D-C5"));
		System.out.println(macToMAC("4-5-60-61-3D-C5"));
		System.out.println(macToMAC("48-5-60-61-3D-C5"));
		System.out.println(macToMAC("48-5D-6-61-3D-C5"));
		System.out.println(macToMAC("48-5D-60-6-3D-C5"));
		System.out.println(macToMAC("48-5D-60-61-3-C5"));
		System.out.println(macToMAC("48-5D-60-61-3D-C"));
		System.out.println(macToMAC("485D60613DC5"));
		System.out.println(checkip("10.22.3.14"));
		System.out.println(checkip("0.0.0.0"));
		System.out.println(checkip("255.255.255.255"));
		System.out.println(checkip("1012.22.23.314"));
		System.out.println(checkip("101.222.23.14"));
		System.out.println(checkip("101.22.232.14"));
		System.out.println(checkip("101.22.23.142"));
		System.out.println(checkip("101.22.256.142"));
	}

	/**
	 * 判断MAC地址是否正确，或将12位MAC转为标准MAC： AA:BB:CC:DD:EE:FF
	 * 
	 * @param mac
	 * @return
	 */
	public static String macToMAC(String mac) {
		String MAC = mac;
		String patternMac = "^[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}+:[a-fA-F0-9]{2}$";
		Pattern pa = Pattern.compile(patternMac);
		boolean isMac = pa.matcher(MAC).find();
		if (isMac) {
			return MAC;
		} else {
			patternMac = "([A-Fa-f0-9]{2}-){5}[A-Fa-f0-9]{2}";
			if (MAC.matches(patternMac)) {
				return MAC;
			} else {
				if (MAC.length() == 12) {
					String tempMacString = "";
					ArrayList<String> b;
					try {
						b = splitByBytes(MAC, 2);
						for (int i = 0; i < b.size(); i++) {
							tempMacString += b.get(i) + ":";
						}
						MAC = tempMacString.substring(0,
								tempMacString.length() - 1);
						isMac = pa.matcher(MAC).find();
						if (isMac) {
							return MAC;
						} else {
							return "FALSE";
						}
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
						return "FALSE";
					}

				} else {
					return "FALSE";
				}

			}
		}
	}

	// 功能：按固定长度来分割字符串 chenst
	private static ArrayList<String> splitByBytes(String text, int length)
			throws UnsupportedEncodingException {
		String encode = "GBK";
		ArrayList<String> list = new ArrayList<String>();
		StringBuilder sb = new StringBuilder();
		int currentLength = 0;
		for (int i = 0; i < text.toCharArray().length; i++) {
			char c = text.charAt(i);
			currentLength += String.valueOf(c).getBytes(encode).length;
			if (currentLength <= length) {
				sb.append(c);
			} else {
				currentLength = 0;
				currentLength += String.valueOf(c).getBytes(encode).length;
				list.add(sb.toString());
				sb.replace(0, sb.length(), "");
				sb.append(c);
			}
			if (i == text.toCharArray().length - 1)
				list.add(sb.toString());
		}
		return list;
	}

	/**
	 * 判断IP地址是否正确
	 * 
	 * @param ip
	 * @return
	 */
	public static boolean checkip(String ip) {
		final Pattern IP_PATTERN = Pattern
				.compile("([1-9]|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3}");
		return IP_PATTERN.matcher(ip).matches();
	}
}
