package com.zy.sms.util;

import com.zy.sms.admin.entity.RoleEntity;
import com.zy.sms.admin.entity.UserEntity;
import com.zy.sms.admin.entity.UserRoleEntity;
import com.zy.sms.admin.entity.UserRoleEntityPK;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;


import javax.servlet.ServletOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class ExcelUtil {


    /**
     * 导出所用学生到excle表格中
     * @param userList 学生列表
     * @param outputStream 制定文件的输出流
     */
    public static void exportUserExcel(List<UserEntity> userList, ServletOutputStream outputStream){
        try{
            //创建工作簿
            HSSFWorkbook workbook=new HSSFWorkbook();
            //设置标题样式
            HSSFCellStyle style1=createCellStyle(workbook,(short)15);
            //设置列标题样式
            HSSFCellStyle style2=createCellStyle(workbook,(short)13);

            //创建工作表 并设置表名
            HSSFSheet sheet=workbook.createSheet("学生列表");

            //创建合并单元格对象
            CellRangeAddress cellRangeAddress=new CellRangeAddress(0,0,0,6);
            //添加合并单元格对象
            sheet.addMergedRegion(cellRangeAddress);
            //设置默认的列宽
            sheet.setDefaultColumnWidth(25);

            //创建标题行
            HSSFRow titleRow=sheet.createRow(0);
            //创建标题单元格
            HSSFCell titleCell=titleRow.createCell(0);
            //设置样式
            titleCell.setCellStyle(style1);
            //设置单元格内容
            titleCell.setCellValue("学生列表");

            //列标题行的标题
            String cellTitle[]=new String[]{"学生姓名","学号","学院","班级","性别","电子邮箱","电话号码"};
            //创建列标题行
            HSSFRow cellTitleRow=sheet.createRow(1);
            //设置标题
            for(int i=0;i<cellTitle.length;i++){
                HSSFCell cell=cellTitleRow.createCell(i);
                //设置样式
                cell.setCellStyle(style2);
                //设置内容
                cell.setCellValue(cellTitle[i]);
            }

            //输出学生的信息
            if(userList!=null){
                for(int j=0;j<userList.size();j++){
                    UserEntity user=userList.get(j);
                    HSSFRow row=sheet.createRow(j+2);
                    //姓名
                    HSSFCell nameCell=row.createCell(0);
                    nameCell.setCellValue(user.getName());
                    //账号
                    HSSFCell accountCell=row.createCell(1);
                    accountCell.setCellValue(user.getAccount());
                    //学院
                    HSSFCell deptCell=row.createCell(2);
                    deptCell.setCellValue(user.getDeptName());
                    //班级
                    HSSFCell classCell=row.createCell(3);
                    classCell.setCellValue(user.getClassName());
                    //性别
                    HSSFCell genderCell=row.createCell(4);
                    genderCell.setCellValue(user.getGender());
                    //电子邮箱
                    HSSFCell eamilCell=row.createCell(5);
                    eamilCell.setCellValue(user.getEmail());
                    //电话
                    HSSFCell mobilelCell=row.createCell(6);
                    mobilelCell.setCellValue(user.getMobile());
                }
            }
            workbook.write(outputStream);
            workbook.close();
        }catch (IOException e){
            throw new RuntimeException("无法导出！"+e);
        }
    }

    /**
     * 设置单元的样式
     * @param workbook 工作本
     * @param fontSize 字体的大小
     * @return 单元格样式
     */
    private static HSSFCellStyle createCellStyle(HSSFWorkbook workbook,short fontSize){
        HSSFCellStyle style=workbook.createCellStyle();
        //水平居中
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        //创建字体的样式
        HSSFFont font=workbook.createFont();
        //字体加粗
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        //字体大小
        font.setFontHeightInPoints(fontSize);
        //加载字体
        style.setFont(font);
        return style;
    }

    //获取学生
    public static List<UserEntity> importExcel(InputStream inputStream, String userExcelFileName){
        List<UserEntity> userList=null;
        try{
            Workbook workbook;
            boolean isExcelFile=userExcelFileName.matches("^.+\\.(?i)(xls)$");
            //读取工作簿
            if (isExcelFile) {
                workbook= new HSSFWorkbook(inputStream);
            }else {
                return new ArrayList<>();
            }
            //读取表
            Sheet sheet=workbook.getSheetAt(0);
            //读取行
            int rowNum=sheet.getPhysicalNumberOfRows();
            if(rowNum>2){
                UserEntity user;
                userList=new ArrayList<UserEntity>();

                for(int i=2;i<rowNum;i++){
                    Row row=sheet.getRow(i);
                    user=new UserEntity();
                    //姓名
                    Cell nameCell=row.getCell(0);
                    user.setName(nameCell.getStringCellValue());
                    //账号
                    Cell accountCell=row.getCell(1);
                    accountCell.setCellType(Cell.CELL_TYPE_STRING);
                    user.setAccount(accountCell.getStringCellValue());
                    //学院
                    Cell deptCell=row.getCell(2);
                    user.setDeptName(deptCell.getStringCellValue());
                    //班级
                    Cell classCell=row.getCell(3);
                    user.setClassName(classCell.getStringCellValue());
                    //性别
                    Cell genderCell=row.getCell(4);
                    user.setGender(genderCell.getStringCellValue());
                    //手机号
                    Cell mobileCell=row.getCell(5);
                    String mobile;
                    try{
                        mobile=mobileCell.getStringCellValue();
                    }catch (Exception e){//手机号码被记录为科学技术形式，则需要使用数值型整形式然后转换
                        Double bmobile=mobileCell.getNumericCellValue();
                        mobile= BigDecimal.valueOf(bmobile).toString();
                    }
                    user.setMobile(mobile);
                    //电子邮箱
                    Cell emailCell=row.getCell(6);
                    user.setEmail(emailCell.getStringCellValue());
                    //角色的Id
                    Cell roleIdCell=row.getCell(7);
                    roleIdCell.setCellType(Cell.CELL_TYPE_STRING);
                    //j角色
                    RoleEntity roleEntity=new RoleEntity(roleIdCell.getStringCellValue());
                    //学生与角色联邦
                    UserRoleEntityPK userRoleEntityPK=new UserRoleEntityPK(roleEntity,accountCell.getStringCellValue());
                    UserRoleEntity userRoleEntity=new UserRoleEntity(userRoleEntityPK);
                    List list=new ArrayList<UserRoleEntity>();
                    list.add(userRoleEntity);
                    user.setUserRoles(list);

                    user.setId(accountCell.getStringCellValue()); //Id
                    //设置默认密码
                    user.setPassword("123456");
                    //设置学生的状态 默认有效
                    user.setState(UserEntity.USER_STATE_VALID);
                    userList.add(user);
                }
            }
            workbook.close();
            inputStream.close();
        }catch (IOException e){
            throw new RuntimeException("读取文件失败"+e);
        }
        return userList;
    }
}
