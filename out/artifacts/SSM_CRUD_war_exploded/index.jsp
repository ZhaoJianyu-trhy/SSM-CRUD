<%--
  Created by IntelliJ IDEA.
  User: M
  Date: 2020/7/7
  Time: 9:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <%--    &lt;%&ndash;    引入jquery&ndash;%&gt;--%>
    <%--    WEB的路径问题：不以/开始的，是相对路径，找资源是以当前资源为路径基准,经常容易出问题
    以/开始的相对路径，它找资源，是以服务器的路径位标准:https://localhost:3306/crud,需要加上项目名
    --%>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <%--    &lt;%&ndash;    引入样式&ndash;%&gt;--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
</head>
<body>

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_input"
                                   placeholder="email@zjy.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_input" value="m" checked=checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_input" value="f"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--                            部门ID--%>
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--员工修改模态框--%>
<div class="modal fade" id="empUpdataModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update"
                                   placeholder="email@zjy.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update" value="m" checked=checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update" value="f"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--                            部门ID--%>
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


<%--搭建显示页面--%>
<div class="container">
    <%--    标题行--%>
    <div class="row">
        <div class="col-md-12">
            <h1>赵氏集团</h1>
        </div>
    </div>
    <%--    按钮--%>
    <div class="row">
        <div class="col-md-offset-8">
            <button class="btn-primary" id="emp_add_btn">新增</button>
            <button class="btn-danger" id="emp_delete_all">删除</button>
        </div>
    </div>
    <%--    显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--    显示分页信息--%>
    <div class="row">
        <%--        分页文字信息--%>
        <div class="col-md-6" id="page_info_area"></div>
        <%--        分页条信息--%>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>

<script type="text/javascript">
    var totalRecord;
    let currentPage;
    //1.页面加载完成后，直接发送去ajax请求，要到分页数据
    $(function () {
        to_page(1)
    });

    //创建编辑按钮之前就绑定了click，所以绑定不上
    //可以在创建按钮时就绑定.或者().live()
    //但是jquery新版没有live方法，使用on替代
    $(document).on(("click"), ".edit_btn", function () {

        //查出员工信息

        //查出部门信息，并显示部门列表
        // reset_form("#empAddModel form");
        // $("#empAddModel form")[0].reset();
        getDepts("#empUpdataModel select");
        getEmp($(this).attr("edit_id"));

        //把员工id传递给更新按钮
        $("#emp_update_btn").attr("edit_id", $(this).attr("edit_id"))
        $("#empUpdataModel").modal({
            backdrop: "static"
        })
    });

    //单个删除
    $(document).on(("click"), ".delete_btn", function () {

        //弹出是否确认对话框
        // alert($(this).parents("tr").find("td:eq(1)").text());
        let empName = $(this).parents("tr").find("td:eq(2)").text();
        let empId = $(this).attr("delete_id")
        if (confirm("确认删除【" + empName + "】吗？")) {
            //确认，发送ajax请求
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }

    });

    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        var emailName = $("#email_update").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

        if (!regEmail.test(emailName)) {
            // alert("邮箱格式不正确")
            show_validate_msg("#email_update", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_update", "success", "");
        }

        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit_id"),
            type: "PUT",
            data: $("#empUpdataModel form").serialize(),
            success: function (result) {
                //1.关闭对话框
                $("#empUpdataModel").modal('hide');
                //2.回到页面
                to_page(currentPage);
            }
        })
    })

    function getEmp(id) {

        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                // console.log(result);
                var empEle = result.extend.emp;
                $("#empName_update_static").text(empEle.empName);
                $("#email_update").val(empEle.email);
                $("#empUpdataModel input[name = gender]").val([empEle.gender]);
                $("#empUpdataModel select").val([empEle.dId]);
            }

        })
    }

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                $("#check_all").prop("checked", false);
                //1解析并显示员工数据
                build_emp_table(result);
                //2解析并显示分页信息
                build_page_info(result);
                //3解析显示分页条数据
                build_page_nav(result);
            }
        })
    }

    function build_emp_table(result) {
        //清空，为了点击页码的正确性
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            let checkBoxTd = $("<td></td>").append("<input type = 'checkbox' class='check_item'>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "m" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            //按钮
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //给编辑按钮添加一个自定义的属性，来表示当前员工的id
            editBtn.attr("edit_id", item.empId);
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            deleteBtn.attr("delete_id", item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
            //append方法执行后，返回原来的元素，所以可以链式添加
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");
        })
    }

    //解析分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第" + result.extend.pageInfo.pageNum + "页,总" + result.extend.pageInfo.pages + "页,总" + result.extend.pageInfo.total + "条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    // function build_page_info(result){
    //     $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+
    //         result.extend.pageInfo.pages+"页,总"+
    //         result.extend.pageInfo.total+"条记录");
    // }
    //解析分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        //为元素添加点击翻页的事件
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {

            //为元素添加点击翻页的事件
            firstPageLi.click(function () {
                to_page(1);
            })

            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            })
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));

        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            })

            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            })
        }


        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            //判断是否当前页码
            if (result.extend.pageInfo.pageNum == item)
                numLi.addClass("active");
            numLi.click(function () {
                to_page(item);
            })
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area")
    }

    /**
     * 清空表单样式及内容
     * @param ele
     */
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    $("#emp_add_btn").click(function () {
        //发送ajax请求，显示在下拉列表中
        //清除表单数据(表单数据和样式重置)
        reset_form("#empAddModel form");
        $("#empAddModel form")[0].reset();
        getDepts("#empAddModel select");
        $("#empAddModel").modal({
            backdrop: "static"
        })
    })

    //查出所有的部门信息，并显示在下拉列表中
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                //部门数据
                // console.log(result);
                //显示部门信息在下拉菜单中
                // $("#dept_add_select").append("<><>")
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        })
    }

    function show_validate_msg(ele, status, msg) {
        //清除当前元素状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验表单数据
    function validate_add_form() {

        //1.拿到要校验的数据
        var empName = $("#empName_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;

        if (!regName.test(empName)) {
            // alert("用户名可以是2-5位中文，或者6-16位英文")
            //清空元素
            show_validate_msg("#empName_input", "error", "用户名可以是2-5位中文，或者6-16位英文")
            return false;
        } else {
            show_validate_msg("#empName_input", "success", "")
        }

        var emailName = $("#email_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

        if (!regEmail.test(emailName)) {
            // alert("邮箱格式不正确")
            show_validate_msg("#email_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_input", "success", "");
        }

        return true;
    }

    $("#empName_input").change(function () {
        //发送ajax请求，校验是否可用
        var empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkUser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        })
    })

    //绑定单击事件
    $("#emp_save_btn").click(function () {
        //将模态框中填写的数据提交给服务器进行保存
        //发送ajax请求，保存员工
        // alert($("#empAddModel form").serialize());

        if (!validate_add_form()) {
            return false;
        }
        //判断用户名校验是否成功，成功则继续
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModel form").serialize(),
            success: function (result) {
                // alert(result.msg);
                //判断返回结果中的状态码，100成功，200失败
                if (result.code == 100) {
                    //1.关闭模态框
                    $("#empAddModel").modal('hide');

                    //2.发送ajax请求,显示最后一页数据即可
                    to_page(totalRecord);
                } else {//校验失败
                    // console.log(result);
                    if (undefined != result.extend.errorMap.email) {
                        //显示邮箱错误信息
                        show_validate_msg("#email_input", "error", result.extend.errorMap.email);
                    }
                    if (undefined != result.extend.errorFields.empName) {
                        //显示员工的名字错误信息
                        show_validate_msg("#empName_input", "error", result.extend.errorMap.empName);
                    }
                }

            }
        })
    });

    //完成全选，全部选功能
    $("#check_all").click(function () {
        // attr获取checked是undefind
        //原生的dom属性,用prop.自定义属性的值，用attr
        //用prop修改和读取dom原生属性的值
        // alert($(this).prop("checked"))
        $(".check_item").prop("checked", $(this).prop("checked"))
    });

    //checkItem
    $(document).on("click", ".check_item", function () {
        //判断当前选中的元素是不是5个
        let flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    //批量删除
    $("#emp_delete_all").click(function () {

        //找到被选中的check_item
        let empNames = "";
        let dele_id = "";
        $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ", ";
            //拿掉empNames最后一个逗号
            dele_id += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        empNames = empNames.substring(0, empNames.length - 2);
        dele_id = dele_id.substring(0, dele_id.length - 1);
        if (confirm("确认删除【" + empNames + "】")) {
            //发送ajax请求
            $.ajax({
                url: "${APP_PATH}/emp/" + dele_id,
                type: "DELETE",
                success: function () {
                    alert("删除成功");
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
