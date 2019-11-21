package com.workplan.bean.wxTemp;

public class TemplateData {
    private Object value;

    public Object getValue() {
        return value;
    }

    public void setValue(Object value) {
        this.value = value;
    }

    public TemplateData(String value) {
        this.value =value;
    }

    public TemplateData() {
    }
}
