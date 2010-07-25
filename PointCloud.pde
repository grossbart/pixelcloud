/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 *
 *  Copyright 2008 Aaron Koblin 
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at 
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
 *  See the License for the specific language governing permissions and
 *  limitations under the License. 
 *
 */ ///////////////////////////////////////////////////////////
   //
  //  Modifications by Peter Gassner <peter@naehrstoff.ch>
 //
//////////////////////////////////////////////////////////////


import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import javax.media.opengl.GL;

public class VBPointCloud {
  PApplet p;
  GL gl; 
  PGraphicsOpenGL pgl;
  public float pointSize = .5f;
  FloatBuffer f, c;
  
  boolean smoothing = true;

  public VBPointCloud(PApplet p) {
    this.p = p;
    this.pgl = (PGraphicsOpenGL) p.g; 
  }

  /* Initializing the ByteBuffer
  ------------------------------------------------ */

  public void loadFloats(float[] points) {
    f = ByteBuffer.allocateDirect(4 * points.length).order(ByteOrder.nativeOrder()).asFloatBuffer();
    f.put(points);
    f.rewind();
  }

  public void loadFloats(float[] points, float[] colors) {
    f = ByteBuffer.allocateDirect(4 * points.length).order(ByteOrder.nativeOrder()).asFloatBuffer();
    f.put(points);
    f.rewind();
    c = ByteBuffer.allocateDirect(4 * colors.length).order(ByteOrder.nativeOrder()).asFloatBuffer();
    c.put(colors);
    c.rewind();
  }

  
  /* Updating the ByteBuffer
  ------------------------------------------------ */
  
  public void updateFloats(float[] points) {
    f.clear();
    f.put(points);
    f.rewind();
  }


  /* Drawing the points
  ------------------------------------------------ */

  public void draw() {
    gl = pgl.beginGL();
      gl.glPointSize(pointSize);

      // Setup Visuals
      gl.glDisable(GL.GL_DEPTH_TEST);
      if (smoothing) gl.glEnable(GL.GL_POINT_SMOOTH);

      // Setup Points
      gl.glEnableClientState(GL.GL_VERTEX_ARRAY);
      gl.glVertexPointer(3, GL.GL_FLOAT, 0, f);

      gl.glEnableClientState(GL.GL_COLOR_ARRAY);
      gl.glColorPointer(4, GL.GL_FLOAT, 0, c);

      // Draw Points
      gl.glDrawArrays(GL.GL_POINTS, 0, f.capacity() / 3);
      gl.glDisableClientState(GL.GL_VERTEX_ARRAY);
    pgl.endGL();
  }
  

  /* Settings
  ------------------------------------------------ */

  void setPointSize(float s) {
    pointSize = s;
  }
  
  void enableSmoothing() {
    smoothing = true;
  }
  
  void disableSmoothing() {
    smoothing = false;
  }
  
}
