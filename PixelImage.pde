public class PixelImage {
  
  Status pstatus;
  Status status;

  PApplet p;
  PImage img;
  VBPointCloud cloud;
  KineticMatrix m;
  
  int gridSize;
  int width, height;

  float[] colors;
  
  float x, y, z;
  float rx, ry;

  float rippleCount = 2.5;
  float rippleDamping = 3;
  float rippleStrength = 50;
  
  float r;
  float R;
  float phi;
  float damping;
  
  float moveToRootSpeed = 10;
  
  float ang = TWO_PI;
  float circumference;
  float xsteps;
  
  
  PixelImage(PApplet p, PImage img, float x, float y, float z, int gridSize) {
    cloud = new VBPointCloud(p);
    cloud.setPointSize(gridSize);
    this.img = img;
    this.x = x;
    this.y = y;
    this.z = z;

    this.gridSize = gridSize;
    this.width = img.width;
    this.height = img.height;

    m = new KineticMatrix(width/gridSize, height/gridSize, gridSize);
    m.setAllP(0f);
    m.setAllV(0f);
    m.setAllA(0f);
    m.setAllF(0.9f);

    status(Status.DEFAULT);
    
    loadPoints();
  }
  
  
  /* Image
  ------------------------------------------------ */
  
  public int width() {
    return width;
  }
  
  public int height() {
    return height;
  }
  
  
  /* Draw
  ------------------------------------------------ */

  void draw() {
    switch(status) {
      case FOLD:
        effectFold();
        break;
      case SHOOT:
        effectShoot();
        break;
      case TISSUE:
        effectTissue();
        break;
      default:
        effectImplode();
    }
    updatePoints();
    cloud.draw();
  }
  
  void loadPoints() {
    //--Initialize Points
    while (m.hasNextCol()) {
      while(m.hasNextRow()) {
        m.setPx(x + m.x());
        m.setPy(y + m.y());
        m.setPz(z);
        m.nextRow();
      }
      m.nextCol();
    }

    //--Initialize Colors
    colors = new float[width*height*4];
    int cstep = 0;
    for (int px = 0; px < width/gridSize; px++) {
      for (int py = 0; py < height/gridSize; py++) {
        color c = img.get(px*gridSize, py*gridSize);
        colors[cstep]     = new Float(red(c)/255f);
        colors[cstep + 1] = new Float(green(c)/255f);
        colors[cstep + 2] = new Float(blue(c)/255f);
        colors[cstep + 3] = new Float(alpha(c)/255f);
        cstep += 4;
      }
    }
    
    //--Initialize Cloud
    cloud.loadFloats(m.points(), colors);
  }

  void updatePoints() {
    while (m.hasNextCol()) {
      while (m.hasNextRow()) {
        m.setVx((m.vx() + m.ax()) * m.fx());
        m.setVy((m.vy() + m.ay()) * m.fy());
        m.setVz((m.vz() + m.az()) * m.fz());
        m.setPx(m.px() + m.vx());
        m.setPy(m.py() + m.vy());
        m.setPz(m.pz() + m.vz());
        m.nextRow();
      }
      m.nextCol();
    }
    cloud.updateFloats(m.points());
  }
  
  
  
  /* Implode to normal state
  ------------------------------------------------ */

  void effectImplode() {
    
    if (pstatus != Status.DEFAULT) {
      m.setAllV(0f);
      m.setAllA(0f);
      status(Status.DEFAULT);
    }
    
    boolean home = true;

    while(m.hasNextCol()) {
      while(m.hasNextRow()) {
        float vX = (x + m.x() - m.px()) / moveToRootSpeed;
        float vY = (y + m.y() - m.py()) / moveToRootSpeed;
        float vZ = (z - m.pz()) / moveToRootSpeed;
        
        if (vX > 0.1 || vY > 0.1 || vZ > 0.1) home = false;

        m.setPx(m.px() + vX);
        m.setPy(m.py() + vY);
        m.setPz(m.pz() + vZ);
        m.nextRow();
      }
      m.nextCol();
    }
    
    if (home) {
      status(Status.TISSUE);
    }
  }
  
  
  
  
  /* Folding Effect
  ------------------------------------------------ */

  void effectFold() {
    
    if (pstatus != Status.FOLD) {
      m.setAllV(0f);
      m.setAllA(0f);
      status(Status.FOLD);
    }
    
    r = 300;
    xsteps = ang/width;
    circumference = 2*r*ang/2;
    
    while(m.hasNextCol()) {
      while(m.hasNextRow()) {
        phi = ang - xsteps * m.y();
        
        m.setPx(m.px() + ((width/2 + x + r * cos(phi))-m.px())/moveToRootSpeed);
        m.setPy(m.py() + ((height/2 + y + r * sin(phi))-m.py())/moveToRootSpeed);
        m.setPz(m.pz() + ((z - 3 * m.x())-m.pz())/moveToRootSpeed);
        m.nextRow();
      }
      m.nextCol();
    }
  }
  

  

  /* Shooting Effect
  ------------------------------------------------ */

  void shoot() {
    status(Status.DEFAULT);
    status(Status.SHOOT);
  }

  void effectShoot() {
    if (pstatus == Status.SHOOT) return;
    status(Status.SHOOT);

    while(m.hasNextCol()) {
      while(m.hasNextRow()) {
        rx = (m.x() - width/2) - rmouseX;
        ry = (m.y() - height/2) - rmouseY;
        r = sqrt(sq(rx) + sq(ry));
        phi = atan2(ry, rx);
        R  = min(width, height);
        damping = (float)Math.exp(-r/R);

        m.setVx(damping * cos(phi) * random(100));
        m.setVy(damping * sin(phi) * random(100));
        m.setVz(damping*random(-100, 50));

        m.nextRow();
      }
      m.nextCol();
    }
  }
  
  
  /* Tissue Effect
  ------------------------------------------------ */
  
  void effectTissue() { 
    if (pstatus != Status.TISSUE) {
      m.setAllV(0f);
      m.setAllA(0f);
      status(Status.TISSUE);
    }
    
    while(m.hasNextCol()) {
      while(m.hasNextRow()) {
        rx = (m.x() - width/2) - rmouseX;
        ry = (m.y() - height/2) - rmouseY;
        r  = sqrt(sq(rx) + sq(ry));
        R  = min(width, height);
        damping = (float)Math.exp(-r/R*rippleDamping);
        m.setPz(sin(r/R * TWO_PI * rippleCount) * rippleStrength * damping);
        m.nextRow();
      }
      m.nextCol();
    }
  }



  /* Schtuff
  ------------------------------------------------ */
  
  void status(Status s) {
    pstatus = status;
    status = s;
  }

  void reset() {
    status(Status.DEFAULT);
    m.setAllV(0f);
    m.setAllA(0f);

    while(m.hasNextCol()) {
      while(m.hasNextRow()) {
        m.setPx(x+m.x());
        m.setPy(y+m.y());
        m.setPz(z);
        m.nextRow();
      }
      m.nextCol();
    }
  }
  
  void increaseRipples() {
    rippleCount++;
  }
  
  void decreaseRipples() {
    if (rippleCount > 2) {
      rippleCount--;
    } else {
      if (rippleCount > 0) rippleCount -= 0.1;
    }
  }
}
