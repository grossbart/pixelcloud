public class SimpleTimer {
  int[] steps;
  int currentStep;
  int previousTime;

  SimpleTimer() {
    previousTime = millis();
  }
  
  SimpleTimer(int[] steps) {
    this.steps = steps;
    previousTime = millis();
  }
  
  public void startWithSteps(int[] steps) {
    this.steps = steps;
  }
  
  public void reset() {
    steps = null;
    previousTime = millis();
  }
  
  public boolean passed(int interval) {
    return (millis() >= previousTime + interval) ? true : false;
  }
  
  public int step() {
    int sum = 0;
    currentStep = 0;
    for (int i = 0; i < steps.length; i++) {
      sum += steps[i];
      if (passed(sum)) currentStep = i + 1; 
    }
    return currentStep;
  }
  
  public int time() {
    return millis() - previousTime;
  }
  
}