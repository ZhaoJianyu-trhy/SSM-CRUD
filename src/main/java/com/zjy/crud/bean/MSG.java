package com.zjy.crud.bean;

import com.github.pagehelper.PageInfo;

import java.util.HashMap;
import java.util.Map;

/**
 * 返回的通用类
 */
public class MSG {

    //状态码 100-成功  200-失败
    private int code;

    //提示信息
    private String msg;

    //用户返回给浏览器的数据
    private Map<String, Object> extend = new HashMap<>();

    public int getCode() {
        return code;
    }

    public static MSG success() {
        MSG res = new MSG();
        res.setCode(100);
        res.setMsg("处理成功");
        return res;
    }

    public static MSG fail() {
        MSG res = new MSG();
        res.setCode(200);
        res.setMsg("处理失败");
        return res;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    public MSG add(String key, Object value) {
        this.getExtend().put(key, value);
        return this;
    }
}
