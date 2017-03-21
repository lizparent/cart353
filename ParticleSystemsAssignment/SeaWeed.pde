//"Seaweed" by oggy
//http://www.openprocessing.org/sketch/154196
//Licensed under Creative Commons Attribution ShareAlike
//https://creativecommons.org/licenses/by-sa/3.0
//https://creativecommons.org/licenses/GPL/2.0/

class SeaWeed
{
  final static float DIST_MAX = 4;//length of each segment
  final static float maxNbSeg = 100;//max number of segments
  final static float minNbSeg = 35;//min number of segments
  final static float maxWidth = 30;//max width of the base line
  final static float minWidth = 11;//min width of the base line
  final static float FLOTATION = 5;//flotation constant
  float mouseDist;//mouse interaction distance
  int nbSegments = (int)random(minNbSeg, maxNbSeg);//number of segments
  PVector[] pos;//position of each segment
  color[] cols;//colors array, one per segment
  MyColor myCol = new MyColor();
  PVector rootNoise = new PVector(random(123456), random(123456));//noise water effect
  float x;//x origin of the weed
  
  SeaWeed(float p_x, float p_y)
  {
    pos = new PVector[nbSegments];
    cols = new color[nbSegments];
    x = p_x;
    mouseDist = map(nbSegments, minNbSeg, maxNbSeg, 25, 60);
    for (int i = 0; i < nbSegments; i++)
    {
      pos[i] = new PVector(p_x, p_y - i * DIST_MAX);
      cols[i] = myCol.getColor();
    }
  }

  void update()
  {
    rootNoise.add(new PVector(.02, .02));
    PVector mouse = new PVector(mouseX, mouseY);

    pos[0] = new PVector(x, height);
    for (int i = 1; i < nbSegments; i++)
    {
      float n = noise(rootNoise.x + .003 * pos[i].x, rootNoise.y + .003 * pos[i].y);
      float noiseForce = (.3 - n) * 4;
      pos[i].x += noiseForce;
      pos[i].y -= FLOTATION;

      //mouse interaction
      float d = PVector.dist(mouse, pos[i]);
      if (d < mouseDist)// && pmouseX != mouseX && abs(pmouseX - mouseX) < 12)
      {
        PVector tmpPV = mouse.get();       
        tmpPV.sub(pos[i]);
        tmpPV.normalize();
        tmpPV.mult(mouseDist);
        tmpPV = PVector.sub(mouse, tmpPV);
        pos[i] = tmpPV.get();
      }

      PVector tmp = PVector.sub(pos[i-1], pos[i]);
      tmp.normalize();
      tmp.mult(DIST_MAX);
      pos[i] = PVector.sub(pos[i-1], tmp);
    }

    myCol.update();
    cols[0] = myCol.getColor();
    for (int i = 0; i < nbSegments; i++)
    {
      if (i > 0)
      {         
        float t = atan2(pos[i].y - pos[i-1].y, pos[i].x - pos[i-1].x) + PI/2;
        float l = map(i, 0, nbSegments-1, map(nbSegments, minNbSeg, maxNbSeg, minWidth, maxWidth), 1);
        float c = cos(t) * l;
        float s = sin(t) * l;
      }
    }

    if(mode == 1) beginShape(LINES);
    for (int i = 0; i < nbSegments; i++)
    {
      if(mode == 0)
      {
        noStroke();
        //stroke(0, 100);
        fill(cols[i]);
        float r = (30 * cos(map(i, 0, nbSegments - 1, 0, HALF_PI)));
        ellipse(pos[i].x, pos[i].y + 10, r, r);
      }else
      {
        noFill();
        stroke(cols[i]);
        strokeWeight(nbSegments-i+int(30 * cos(map(i, 0, nbSegments - 1, 0, HALF_PI))));
        curveVertex(pos[i].x, pos[i].y + 10);
      }
    }
    if(mode == 1) endShape();    
  }
}