package com.zjy.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zjy.crud.bean.Employee;
import com.zjy.crud.bean.MSG;
import com.zjy.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 查询员工数据（分页查询）
     *
     * @return
     */
 /*   @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1")Integer pn, Model model) {
        //引入PageHelper分页插件
        //在查询之前调用,传入起始页码，以及每页展示的数据条数
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的查询，就是一个分页查询
        List<Employee> emps = employeeService.getAll();

        //使用pageInfo包装查询后的结果,只需要将pageinfo交给页面,里面封装了详细的分页信息，包括查询出来的数据
        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", page);
        return "list";
    }*/

    @RequestMapping("/emps")
    @ResponseBody
    public MSG getEmpWithJson(@RequestParam(value = "pn", defaultValue = "1")Integer pn, Model model) {
        //引入PageHelper分页插件
        //在查询之前调用,传入起始页码，以及每页展示的数据条数
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的查询，就是一个分页查询
        List<Employee> emps = employeeService.getAll();

        //使用pageInfo包装查询后的结果,只需要将pageinfo交给页面,里面封装了详细的分页信息，包括查询出来的数据
        PageInfo page = new PageInfo(emps, 5);
        return MSG.success().add("pageInfo", page);
    }

    /**
     * 员工保存
     * 采用JSR303校验，导入Hibernate-Validator包
     * @return
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public MSG saveEmp(@Valid Employee employee, Errors result) {
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return MSG.fail().add("errorMap", map);
        } else {
            employeeService.saveEmp(employee);
            return MSG.success();
        }

    }

    @RequestMapping("/checkUser")
    @ResponseBody
    public MSG checkUserName(String empName) {
        //先判断用户名是否是合法的表达式
        String regName = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        boolean matches = empName.matches(regName);
        if (!matches) {
            return MSG.fail().add("va_msg", "用户名必须是6到16位数组和字母的组合，或者2-5位中文");
        }
        //数据库用户名重复校验
        boolean judge = employeeService.checkUserName(empName);
        if (judge) {
            return MSG.success();
        } else {
            return MSG.fail().add("va_msg", "用户名重复");
        }
    }

    /**
     * 根据id查询员工
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public MSG getEmp(@PathVariable("id") Integer id) {

        Employee emp = employeeService.getEmp(id);
        return MSG.success().add("emp", emp);
    }

    /**
     * 如果直接发送ajax=PUT形式的请求，出现问题：请求体中有数据，但是employee对象封装不上，除了ID其他都没有数据
     * 原因：tomCat：将请求体中的数据，封装一个map。request.getParameter("empName")就会从这个map中取值
     * 而springMVC封装pojo对象时，会把poji中每个属性的值，调用request.getParameter("email")，
     *
     * AJAX直接发送PUT请求的血案：
     *     PUT请求，请求体中的数据，request.getParameter("empName")拿不到
     *     TomCat一看是PUT请求，便不会封装请求体中的数据位map,只有POST形式的请求才封装为map
     *
     * 员工更新方法
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public MSG updateEmp(Employee employee, HttpServletRequest request) {

//        System.out.println(request.getParameter("gender"));
        employeeService.updateEmp(employee);
        return MSG.success();
    }

    /**
     * 单个和批量删除二合一功能
     * @param
     * @return
     */
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public MSG deleteEmpById(@PathVariable("ids") String ids) {
        if (ids.contains("-")) {
            //批量删除

            //组装id
            List<Integer> del_id = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for (String str_id : str_ids) {
                del_id.add(Integer.parseInt(str_id));
            }
            employeeService.deleteBatch(del_id);
        } else {
            //单个删除
            int id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }

        return MSG.success();
    }
}
