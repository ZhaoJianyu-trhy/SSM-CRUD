package com.zjy.crud.test;

import com.github.pagehelper.PageInfo;
import com.zjy.crud.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用Spring测试模块提供的测试请求功能
 * spring4测试的时候，需要servlet3.0的支持
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:springMVC-servlet.xml"})
public class MvcTest {

    //传入springMVC的IOC
    @Autowired
    WebApplicationContext context;
    //虚拟MVC请求，获取到处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求，拿到返回值
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();

        //请求成功之后，在请求域中会有pageInfo,来验证是否正确
        MockHttpServletRequest request = mvcResult.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码:" + pageInfo.getPageNum());
        System.out.println("总页码:" + pageInfo.getPages());
        System.out.println("总记录数:" + pageInfo.getTotal());
        int[] navigatepageNums = pageInfo.getNavigatepageNums();
        for (int num : navigatepageNums) {
            System.out.print(num + " ");
        }

        System.out.println();
        //获取员工数据
        List<Employee> list = pageInfo.getList();
        for (Employee employee : list) {
            System.out.println("ID:" + employee.getEmpId() + " Name:" + employee.getEmpName());
        }
    }
}
