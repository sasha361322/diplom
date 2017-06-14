package ru.shipilov.diplom.logic.utils;

import java.util.List;

public class Histogtam {

    private List<Object> values;
    private Object min;
    private Object max;
    private Object step;
    private Integer stepCount;

    public Histogtam(Object min, Object max, Long cnt) {
        this.min = min;
        this.max = max;
        stepCount = Stat.Sturges(cnt);
        if ((min instanceof Integer)&&(max instanceof Integer))
            step = ((Integer)max - (Integer)min) / cnt;
        else if ((min instanceof Long)&&(max instanceof Long))
            step = ((Long)max - (Long)min) / cnt;
        else
        if ((min instanceof Double)&&(max instanceof Double))
            step = ((Double)max -  (Double)min) / cnt;
        step = ((Integer) max - (Integer) min) / cnt;
    }
    @Override
    public String toString() {
        return "Histogtam{" +
                ", min=" + min +
                ", max=" + max +
                ", step=" + step +
                "values=" + values +
                '}';
    }

    public List<Object> getValues() {
        return values;
    }

    public void setValues(List<Object> values) {
        this.values = values;
    }

    public Object getMin() {
        return min;
    }

    public void setMin(Object min) {
        this.min = min;
    }

    public Object getMax() {
        return max;
    }

    public void setMax(Object max) {
        this.max = max;
    }

    public Object getStep() {
        return step;
    }

    public void setStep(Object step) {
        this.step = step;
    }

    public Integer getStepCount() {
        return stepCount;
    }

    public void setStepCount(Integer stepCount) {
        this.stepCount = stepCount;
    }
}
