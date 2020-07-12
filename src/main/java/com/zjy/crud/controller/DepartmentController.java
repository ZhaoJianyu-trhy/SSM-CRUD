package com.zjy.crud.controller;


import com.zjy.crud.bean.Department;
import com.zjy.crud.bean.MSG;
import com.zjy.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理和部门有关的请求
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("depts")
    @ResponseBody
    public MSG getDepts() {

        //查出的所有部门信息
        List<Department> list = departmentService.getDepts();
        return MSG.success().add("depts", list);
    }

}
