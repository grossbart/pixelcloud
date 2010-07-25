public class Float3D {

  public final static int COLS = 3;
  private float[] values;
  private int pointer;
  private int c1, c2, c3;

  Float3D(int size) {
    values = new float[size];
    rewind();
  }
  
  
  /* Positioning
  ------------------------------------------------ */
  public void rewind() {
    pointer = 0;
    c1 = pointer;
    c2 = pointer+1;
    c3 = pointer+2;
  }
  public void forward() {
    if (isLastRow()) {
      pointer = 0;
    } else {
      pointer += COLS;
    }
    c1 = pointer;
    c2 = pointer+1;
    c3 = pointer+2;
  }


  /* Manipulation
  ------------------------------------------------ */
  public void add(float f1, float f2, float f3) {
    values[c1] = f1;
    values[c2] = f2;
    values[c3] = f3;
    forward();
  }
  

  /* Getters
  ------------------------------------------------ */
  public float[] values() {
    return values;
  }

  public int size() {
    return values.length/COLS;
  }
  
  public float x() {
    return values[pointer];
  }
  
  public float y() {
    return values[pointer+1];
  }
  
  public float z() {
    return values[pointer+2];
  }
  
  public float x(int pos) {
    return values[pos*3];
  }

  public float y(int pos) {
    return values[pos*3+1];
  }

  public float z(int pos) {
    return values[pos*3+2];
  }

  
  public boolean isLastRow() {
    if (pointer == values.length - COLS) return true;
    return false;
  }


  /* Setters
  ------------------------------------------------ */
  
  public void setX(int pos, float f) {
    values[pos*3] = f;
  }
  
  public void setY(int pos, float f) {
    values[pos*3+1] = f;
  }
  
  public void setZ(int pos, float f) {
    values[pos*3+2] = f;
  }

  public void setRow(float f) {
    values[c1] = f;
    values[c2] = f;
    values[c3] = f;
  }

  public void setRow(float f1, float f2, float f3) {
    values[c1] = f1;
    values[c2] = f2;
    values[c3] = f3;
  }

  public void init() {
    reset(0f);
  }
  
  public void fill(float f) {
    reset(f);
  }

  public void reset(float f) {
    for (int i = 0; i < values.length; i++) {
      values[i] = f;
    }
  }
  
}