
public class asd {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String headers="id," +
				"apa_id," +
				"roo_id," +
				"roo_name," +
				"roo_floor," +
				"roo_people," +
				"roo_remarks," +
				"roo_price," +
				"roo_allocation";
		headers=headers.replaceAll(" ", "");
		//先逗号分隔
		System.out.println("--------------------------------");
		String[] arrStrings=headers.replaceAll(" ", "").split(",");

		for (int i = 0; i < arrStrings.length; i++) {
			System.out.println("private String "+arrStrings[i]+";");
		}
		System.out.println("********************************");
		for (int i = 0; i < arrStrings.length; i++) {
			System.out.println("info.set"+captureName(arrStrings[i])+"("+arrStrings[i]+");");
		}
		System.out.println("********************************");
		for (int i = 0; i < arrStrings.length; i++) {
			System.out.println("info.set"+captureName(arrStrings[i])+"(rs.getString(\""+arrStrings[i]+"\"));");
		}
		System.out.println("================================");
		for (int i = 0; i < arrStrings.length; i++) {
			System.out.println("bean.get"+captureName(arrStrings[i])+"(),");
		}
		System.out.println("================================");
		for (int i = 0; i < arrStrings.length; i++) {
			//分隔下划线_
			String[] brrString=arrStrings[i].split("_");
			String CAPTURE="";
			for (int j = 0; j < brrString.length; j++) {
				CAPTURE+=captureName(brrString[j]);
			}
			System.out.println("System.out.println(\"bean.get"+captureName(arrStrings[i])+"()=\"+bean.get"+captureName(arrStrings[i])+"());");
		}
		System.out.println("================================");
		for (int i = 0; i < arrStrings.length; i++) {
			System.out.println("ps.setString("+(i+1)+", list.get(i).get"+captureName(arrStrings[i])+"());");
		}
		System.out.println("================================");
		for (int i = 0; i < arrStrings.length; i++) {
			System.out.println("+\", "+arrStrings[i]+"=\"+list.get(i).get"+captureName(arrStrings[i])+"()");
		}
		
		
		
	}
    //首字母大写
    public static String captureName(String name) {
        char[] cs=name.toCharArray();
        cs[0]-=32;
        return String.valueOf(cs);
        
    }
}
