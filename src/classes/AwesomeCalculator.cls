/**
 * Created by dmeli on 05.11.19.
 */

public class AwesomeCalculator {
    public static Double add(Double x, Double y) {
        calculatorServices.CalculatorImplPort calculator =
                new calculatorServices.CalculatorImplPort();
        return calculator.doAdd(x,y);
    }
}