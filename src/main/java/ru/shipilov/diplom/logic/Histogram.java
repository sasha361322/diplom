package ru.shipilov.diplom.logic;

import java.util.ArrayList;
import java.util.List;

public class Histogram {
    private Object min;
    private Object max;
    private Object step;
    private Integer stepCount;
    private List<Long> frequencies;
    private Double expectation=0.0;//матожидание
    private Double dispersion=0.0;
    private List<Double> middleOfIntervals;

    public static int Sturges(Long count){
        return (int)(1+3.322*Math.log10(count));
    }


    @Override
    public String toString() {
        return "Histogram{" +
                "min=" + min +
                ", max=" + max +
                ", step=" + step +
                ", stepCount=" + stepCount +
                ", frequencies=" + frequencies +
                '}';
    }

    public void calculateDispersion(){
        Double x2=0.0;
        Long sum=0l;
        for (int i=0;i<stepCount;i++){
            expectation += frequencies.get(i)*middleOfIntervals.get(i);
            sum+=frequencies.get(i);
            x2 += frequencies.get(i)*middleOfIntervals.get(i)*middleOfIntervals.get(i);
        }
        expectation = expectation/sum;
        for (int i=0;i<stepCount;i++){
            dispersion += (middleOfIntervals.get(i)-expectation*expectation)*(middleOfIntervals.get(i)-expectation*expectation)*frequencies.get(i);
        }
        dispersion = dispersion/sum;
    }

    public Histogram(Object min, Object max, Long cnt) {
        if (cnt==0) return;
        this.min = min;
        this.max = max;
        stepCount = Histogram.Sturges(cnt);
        if (stepCount>20)
            stepCount = 20;
        middleOfIntervals = new ArrayList<>();
        if ((min instanceof Integer)&&(max instanceof Integer)) {
            step = ((Integer) max - (Integer) min) / stepCount;
            for(int i=0; i<stepCount-1;i++){
                Integer to = (Integer) min + (Integer) step * (i + 1);
                Integer from = (Integer) min + (Integer) step * i;
                middleOfIntervals.add((to+from)/2.0);
            }
            middleOfIntervals.add(((Integer)max + (Integer) min + (Integer) step * (stepCount - 1))/2.0);
        }
        else if ((min instanceof Long)&&(max instanceof Long)) {
            step = ((Long) max - (Long) min) / stepCount;
            for(int i=0; i<stepCount-1;i++){
                Long to = (Long) min + (Long) step * (i + 1);
                Long from = (Long) min + (Long) step * i;
                middleOfIntervals.add((to+from)/2.0);
            }
            middleOfIntervals.add(((Long)max + (Long) min + (Long) step * (stepCount - 1))/2.0);
        }
        else
        if ((min instanceof Double)&&(max instanceof Double)) {
            step = ((Double) max - (Double) min) / stepCount;
            for(int i=0; i<stepCount-1;i++){
                Double to = (Double) min + (Double) step * (i + 1);
                Double from = (Double) min + (Double) step * i;
                middleOfIntervals.add((to+from)/2.0);
            }
            middleOfIntervals.add(((Double)max + (Double) min + (Double) step * (stepCount - 1))/2.0);
        }
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

    public List<Long> getFrequencies() {
        return frequencies;
    }

    public void setFrequencies(List<Long> frequencies) {
        this.frequencies = frequencies;
    }

    public Double getExpectation() {
        return expectation;
    }

    public void setExpectation(Double expectation) {
        this.expectation = expectation;
    }

    public Double getDispersion() {
        return dispersion;
    }

    public void setDispersion(Double dispersion) {
        this.dispersion = dispersion;
    }
}
