public class Calc {

  // Ist Punkt in Rechteck?
  public static boolean withinRect(float px, float py, float x1, float y1, float x2, float y2) {
    if (withinBounds(px, x1, x2) && withinBounds(py, y1, y2)) return true;
    return false;
  }
  
  // Ist Punkt zwischen zwei Punkten?
  public static boolean withinBounds(float px, float x1, float x2) {
    if (px >= x1 && px <= x2) return true;
    return false;
  }
  
  /* Fitting
  ------------------------------------------------ */
  public static float fitWithinRect(float w, float h, float nw, float nh) {
    float arw = nw/w;
    float arh = nh/h;

    if (arw >= arh) {
      return nh/h;
    } else {
      return nw/w;
    }
  }
  
  /* Images
  ------------------------------------------------ */
  public static float aspect(float w, float h) {
    return w/h;
  }

}