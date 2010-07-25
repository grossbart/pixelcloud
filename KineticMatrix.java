public class KineticMatrix {

  float gridSize;
  int col, row;
  int cols, rows;
  
  Float3D points;
  Float3D velocities;
  Float3D accelerations;
  Float3D frictions;

  KineticMatrix(int cols, int rows) {
    this.cols = cols;
    this.rows = rows;
    this.gridSize = 1;
    initialize();
  }

  KineticMatrix(int cols, int rows, float gridSize) {
    this.cols = cols;
    this.rows = rows;
    this.gridSize = gridSize;
    initialize();
  }
  
  private void initialize() {
    col = 0;
    row = 0;
    
    points        = new Float3D(cols*rows*3);
    velocities    = new Float3D(cols*rows*3);
    accelerations = new Float3D(cols*rows*3);
    frictions     = new Float3D(cols*rows*3);    
  }
  
  
  /* Movement
  ------------------------------------------------ */

  public boolean hasNextRow() {
    if (row < rows) return true;
    row = 0;
    return false;
  }
  
  public boolean hasNextCol() {
    if (col < cols) return true;
    col = 0;
    return false;
  }
  
  public void nextRow() {
    row++;
  }
  
  public void nextCol() {
    col++;
  }

  public void rewind() {
    col = 0;
    row = 0;
  }
  
  
  /* Dimensions
  ------------------------------------------------ */
  
  public int rows() {
    return rows;
  }
  
  public int cols() {
    return cols;
  }


  /* Getters
  ------------------------------------------------ */
  
  public float x() {
    return col*gridSize;
  }
  
  public float y() {
    return row*gridSize;
  }
  
  public float[] points() {
    return points.values();
  }

  public float px() {
    return points.x(col*rows + row);
  }
  
  public float py() {
    return points.y(col*rows + row);
  }
  
  public float pz() {
    return points.z(col*rows + row);
  }
  
  public float vx() {
    return velocities.x(col*rows + row);
  }
  
  public float vy() {
    return velocities.y(col*rows + row);
  }
  
  public float vz() {
    return velocities.z(col*rows + row);
  }
  
  public float ax() {
    return accelerations.x(col*rows + row);
  }
  
  public float ay() {
    return accelerations.y(col*rows + row);
  }
  
  public float az() {
    return accelerations.z(col*rows + row);
  }
  
  public float fx() {
    return frictions.x(col*rows + row);
  }
  
  public float fy() {
    return frictions.y(col*rows + row);
  }
  
  public float fz() {
    return frictions.z(col*rows + row);
  }
  
  
  /* Setters
  ------------------------------------------------ */

  public void setAllP(float f) {
    points.fill(f);
  }

  public void setPx(float f) {
    points.setX(col*rows + row, f);
  }
  
  public void setPy(float f) {
    points.setY(col*rows + row, f);
  }
  
  public void setPz(float f) {
    points.setZ(col*rows + row, f);
  }
  
  public void setAllV(float f) {
    velocities.fill(f);
  }
  
  public void setVx(float f) {
    velocities.setX(col*rows + row, f);
  }
  
  public void setVy(float f) {
    velocities.setY(col*rows + row, f);
  }
  
  public void setVz(float f) {
    velocities.setZ(col*rows + row, f);
  }
  
  public void setAllA(float f) {
    accelerations.fill(f);
  }
  
  public void setAx(float f) {
    accelerations.setX(col*rows + row, f);
  }
  
  public void setAy(float f) {
    accelerations.setY(col*rows + row, f);
  }
  
  public void setAz(float f) {
    accelerations.setZ(col*rows + row, f);
  }
  
  public void setAllF(float f) {
    frictions.fill(f);
  }
    
  public void setFx(float f) {
    frictions.setX(col*rows + row, f);
  }
  
  public void setFy(float f) {
    frictions.setY(col*rows + row, f);
  }
  
  public void setFz(float f) {
    frictions.setZ(col*rows + row, f);
  }

}