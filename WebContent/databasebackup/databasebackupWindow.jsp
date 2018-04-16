<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.rms.model.*" %>
<%@ page import="com.rms.util.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>databasebackup Managerment</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <script src="../scripts/boot.js" type="text/javascript"></script>
    

    <style type="text/css">
    html, body
    {
        font-size:12px;
        padding:0;
        margin:0;
        border:0;
        height:100%;
        overflow:hidden;
    }
    </style>
</head>
<body>    
     
    <form id="form1" method="post">
        <input name="id" class="mini-hidden" />
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
                <tr>
                    <td style="width:150px;">Source Table Name:</td>
                    <td style="width:150px;">    
              <!--          <select name="source_tablename" id="source_tablename">
		            	<option value="dining_table">dining_table</option>
		            	<option value="menu">menu</option>
		            	<option value="menu_category">menu_category</option>
		            	<option value="order">order</option>
		            	<option value="order_detail">order_detail</option>
		            	<option value="user">user</option>
                   </select> -->
                   
                          <input name="source_tablename" class="mini-combobox" valueField="title" textField="title" 
                            url="../GetCatagoryServlet?type=source_tablename"
                             emptyText=""
                         />
                    </td>
                </tr>
       
                <tr>
                    <td style="width:150px;">Backup Table Name:</td>
                    <td style="width:150px;">    
                        <input name="backup_tablename" class="mini-textbox" required="true"  emptyText=""/>
                    </td>
                </tr>
                <tr>
                       <tr>
                    <td style="width:150px;">Time:</td>
                    <td style="width:150px;">    
                        <input name=updatetm class="mini-textbox" required="true"  value="<%=DateUtil.getCurrentDateTime()%> " dateFormat="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                </tr>
              
            
            </table>
        </div>
       
        <div style="text-align:center;padding:10px;">               
            <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">Submit</a>       
            <a class="mini-button" onclick="onCancel" style="width:60px;">Cancle</a>       
        </div>        
    </form>
    <script type="text/javascript">
        mini.parse();

        var form = new mini.Form("form1");

        function SaveData() {
            var o = form.getData();            

            form.validate();
            if (form.isValid() == false) return;

            var json = mini.encode([o]);
            $.ajax({
                url: bootPATH+"../DatabaseBackupInfoCrudServlet?method=save",
		        type: 'post',
                data: { data: json },
                cache: false,
                success: function (text) {
                    CloseWindow("save");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    CloseWindow();
                }
            });
        }

        ////////////////////
        //标准方法接口定义
        function SetData(data) {
            if (data.action == "edit") {
                //跨页面传递的数据对象，克隆后才可以安全使用
                data = mini.clone(data);

                $.ajax({
                    url: bootPATH+"../DatabaseBackupInfoCrudServlet?method=get&id=" + data.id,
                    cache: false,
                    success: function (text) {
                        var o = mini.decode(text);
                        form.setData(o);
                        form.setChanged(false);
                    }
                });
            }
        }

        function GetData() {
            var o = form.getData();
            return o;
        }
        function CloseWindow(action) {            
            if (action == "close" && form.isChanged()) {
                if (confirm("Data change ,save it?")) {
                    return false;
                }
            }
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();            
        }
        function onOk(e) {
            SaveData();
        }
        function onCancel(e) {
            CloseWindow("cancel");
        }
        //////////////////////////////////
       



    </script>
</body>
</html>
