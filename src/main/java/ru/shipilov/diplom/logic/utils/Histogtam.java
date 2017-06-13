package ru.shipilov.diplom.logic.utils;

import java.util.List;

public class Histogtam<T> {
    private List<T> values;
    private T min;
    private T max;
    private T step;

    @Override
    public String toString() {
        return "Histogtam{" +
                ", min=" + min +
                ", max=" + max +
                ", step=" + step +
                "values=" + values +
                '}';
    }

    public List<T> getValues() {
        return values;
    }

    public void setValues(List<T> values) {
        this.values = values;
    }

    public T getMin() {
        return min;
    }

    public void setMin(T min) {
        this.min = min;
    }

    public T getMax() {
        return max;
    }

    public void setMax(T max) {
        this.max = max;
    }

    public T getStep() {
        return step;
    }

    public void setStep(T step) {
        this.step = step;
    }
}
