package ru.shipilov.diplom.logic;

import com.fasterxml.jackson.annotation.JsonInclude;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import ru.shipilov.diplom.logic.utils.Xmlable;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

//@JsonAutoDetect
public class Histogram implements Xmlable, Serializable{
    private static final long serialVersionUID = -3504870075238677204L;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Object min;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Object max;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Object step;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Long stepCount;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private List frequencies;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Double expectation=0.0;//матожидание
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Double dispersion=0.0;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private List middleOfIntervals;

    @Override
    public Element getElement(Document doc) {
        Element histogramElement = doc.createElement("histogram");

        Element histogramMin = doc.createElement("min");
        histogramMin.appendChild(doc.createTextNode(this.min.toString()));
        histogramElement.appendChild(histogramMin);

        Element histogramMax = doc.createElement("max");
        histogramMax.appendChild(doc.createTextNode(this.max.toString()));
        histogramElement.appendChild(histogramMax);

        Element histogramStepCount = null;
        Element middleOfIntervals = null;

        if (this.step!=null){
            Element histogramStep = doc.createElement("step");
            histogramStep.appendChild(doc.createTextNode(this.step.toString()));
            histogramElement.appendChild(histogramStep);
            histogramStepCount = doc.createElement("stepCount");
            middleOfIntervals = doc.createElement("middleOfIntervals");
        }
        else {
            histogramStepCount = doc.createElement("count");
            middleOfIntervals = doc.createElement("values");
        }
        histogramStepCount.appendChild(doc.createTextNode(this.stepCount.toString()));
        histogramElement.appendChild(histogramStepCount);

        for(Object o : this.middleOfIntervals) {
            Element value = doc.createElement("value");
            value.appendChild(doc.createTextNode(o.toString()));
            middleOfIntervals.appendChild(value);
        }
        histogramElement.appendChild(middleOfIntervals);

        Element histogramFrequencies = doc.createElement("frequencies");
        for (Object item : this.frequencies){
            Element value = doc.createElement("value");
            value.appendChild(doc.createTextNode(item.toString()));
            histogramFrequencies.appendChild(value);
        }
        histogramElement.appendChild(histogramFrequencies);

        Element expectetion = doc.createElement("expectetion");
        expectetion.appendChild(doc.createTextNode(this.expectation.toString()));
        histogramElement.appendChild(expectetion);

        Element dispersion = doc.createElement("dispersion");
        dispersion.appendChild(doc.createTextNode(this.dispersion.toString()));
        histogramElement.appendChild(dispersion);

        return histogramElement;
    }

    public static int Sturges(Long count){
        return (int)(1+3.322*Math.log10(count));
    }

    public Histogram(Object min, Object max) {
        this.min = min;
        this.max = max;
    }

    public void calculateDispersion(){
        Double x2=0.0;
        Long sum=0l;
        for (int i=0;i<stepCount;i++){
            expectation += (Long)frequencies.get(i)*(Double)middleOfIntervals.get(i);
            sum+=(Long)frequencies.get(i);
            x2 += (Long)frequencies.get(i)*(Double)middleOfIntervals.get(i)*(Double)middleOfIntervals.get(i);
        }
        expectation = expectation/sum;
        for (int i=0;i<stepCount;i++){
            dispersion += ((Double)middleOfIntervals.get(i)-expectation*expectation)*((Double)middleOfIntervals.get(i)-expectation*expectation)*(Long)frequencies.get(i);
        }
        dispersion = dispersion/sum;
    }

    public void udpateHistogram(Long cnt) {
        if (cnt==0) return;
        stepCount = new Long(Histogram.Sturges(cnt));
        if (stepCount>20)
            stepCount = 20l;
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

    public void updatehistogram(List values, List<Double> frequencies, String type){
        this.middleOfIntervals = values;
        this.frequencies = frequencies;
        Double x2 = 0.0;
        switch (type) {
            case "java.lang.Integer":
                for (int i = 0; i < values.size(); i++) {
                    expectation += (Integer) values.get(i) * frequencies.get(i);
                    x2 += (Integer) values.get(i) * (Integer) values.get(i) * frequencies.get(i);
                }
                dispersion = x2 - expectation * expectation;
                break;
            case "java.lang.Double":
                for (int i = 0; i < values.size(); i++) {
                    expectation += (Double) values.get(i) * frequencies.get(i);
                    x2 += (Double) values.get(i) * (Double) values.get(i) * frequencies.get(i);
                }
                dispersion = x2 - expectation * expectation;
                break;
            case "java.lang.Long":
                for (int i = 0; i < values.size(); i++) {
                    expectation += (Long) values.get(i) * frequencies.get(i);
                    x2 += (Long) values.get(i) * (Long) values.get(i) * frequencies.get(i);
                }
                dispersion = x2 - expectation * expectation;
                break;
        }
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
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

    public Long getStepCount() {
        return stepCount;
    }

    public void setStepCount(Long stepCount) {
        this.stepCount = stepCount;
    }

    public List getFrequencies() {
        return frequencies;
    }

    public void setFrequencies(List frequencies) {
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

    public List getMiddleOfIntervals() {
        return middleOfIntervals;
    }

    public void setMiddleOfIntervals(List middleOfIntervals) {
        this.middleOfIntervals = middleOfIntervals;
    }
}
