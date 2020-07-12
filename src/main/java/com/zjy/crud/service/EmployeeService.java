package com.zjy.crud.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zjy.crud.bean.Employee;
import com.zjy.crud.bean.EmployeeExample;
import com.zjy.crud.dao.EmployeeMapper;
import org.omg.CORBA.MARSHAL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll() {
        // TODO Auto-generated method stub
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 员工保存方法
     * @param employee
     */
    public void saveEmp(Employee employee) {

        employeeMapper.insertSelective(employee);
    }

    /**
     * 检查用户是否存在，不存在则返回true
     * @param empName
     * @return
     */
    public boolean checkUserName(@RequestParam("empName") String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long num = employeeMapper.countByExample(example);
        return num == 0;
    }

    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void updateEmp(Employee employee) {

        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 员工删除
     * @param id
     */
    public void deleteEmp(Integer id) {

        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {

        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //delete from xx where emp_id in (1, 2, 3```)  批量删除方法
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
