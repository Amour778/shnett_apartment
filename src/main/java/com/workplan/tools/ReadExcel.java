package com.workplan.tools;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class ReadExcel {

	/** 错误信息 */
    private String errorInfo;
    
    
    /** 
     * @描述：根据文件名读取excel文件 
     */  
    public List<List<String>> read(String filePath){
        List<List<String>> dataLst = new ArrayList<List<String>>();  
        InputStream is = null;  
        try{
            /** 判断文件的类型，是2003还是2007 */  
            boolean isExcel2003 = true; 
            if (ExcelVersionUtil.isExcel2007(filePath)){
                isExcel2003 = false;  
            }  
            /** 调用本类提供的根据流读取的方法 */  
            is = new FileInputStream(new File(filePath));
            Workbook wb = null;  
            if (isExcel2003){  
                wb = new HSSFWorkbook(is);  
            }else{  
                wb = new XSSFWorkbook(is);  
            }
            is.close();
        }catch (IOException e){  
            e.printStackTrace();  
        }catch (Exception ex){  
            ex.printStackTrace();  
        }finally{  
            if (is != null){  
                try{  
                    is.close();  
                }catch (IOException e){  
                    is = null;  
                    e.printStackTrace();  
                }  
            }  
        }  
        return dataLst;  
    }
    
    /** 
     * @描述：读取数据 
     */  
    private List<List<String>> read(Workbook wb){  
        List<List<String>> dataLst = new ArrayList<List<String>>();
        /**得到总的shell */
        int sheetAccount = wb.getNumberOfSheets();
        /** 得到第一个shell */
        Sheet sheet = wb.getSheetAt(0);  
        /** 得到Excel的行数 */  
        int rowCount = sheet.getPhysicalNumberOfRows();
        /** 也可以通过得到最后一行数*/
        int lastRowNum = sheet.getLastRowNum();
        /** 循环Excel的行 */  
        for (int r = 0; r < rowCount; r++){  
            Row row = sheet.getRow(r);  
            if (row == null){  
                continue;  
            }  
            List<String> rowLst = new ArrayList<String>();  
            /** 循环Excel的列 */  
            for (int c = 0; c < row.getPhysicalNumberOfCells(); c++){  
                Cell cell = row.getCell(c);  
                String cellValue = "";  
                if (null != cell){
                	//数据插入操作
                	
                }  
                System.out.print(cellValue +"\t");
                rowLst.add(cellValue);  
            }
            System.out.println();
            dataLst.add(rowLst);  
        }  
        return dataLst;  
    }  
}