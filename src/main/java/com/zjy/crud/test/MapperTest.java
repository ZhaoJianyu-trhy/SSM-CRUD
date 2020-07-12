package com.zjy.crud.test;

import com.zjy.crud.bean.Department;
import com.zjy.crud.bean.Employee;
import com.zjy.crud.dao.DepartmentMapper;
import com.zjy.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.jupiter.api.DynamicTest;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 测试DAO层
 */
//使用Spring的单元测试,可以自动注入我们需要的组件
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;
    @Test
    public void testCRUD() {
//        System.out.println(departmentMapper);

        //测试部门插入
//        departmentMapper.insertSelective(new Department(null, "开发部"));
//        departmentMapper.insertSelective(new Department(null, "测试部"));

        //测试员工插入
//        employeeMapper.insertSelective(new Employee(null, "赵小军", "m", "zxj@zjy.com", 1));

        //批量插入多个员工,可以使用执行批量操作的sqlSession
//        for () {
//            employeeMapper.insertSelective(new Employee(null, "赵小军", "m", "zxj@zjy.com", 1));
//        }
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String substring = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, substring, "m", substring + "@zjy.com", 1));
        }
        System.out.println("批量添加完成");
    }



}
