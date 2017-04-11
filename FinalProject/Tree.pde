//"tree" by Patrick Lee
//http://www.openprocessing.org/sketch/208768
//Licensed under Creative Commons Attribution ShareAlike
//https://creativecommons.org/licenses/by-sa/3.0
//https://creativecommons.org/licenses/GPL/2.0/

class Tree {
  PImage mt;
  int fit=0;
  int i;
  int x;
  int y;
  
  public Tree(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void drawTree()
  {
    pushMatrix();
    translate(x, y);
    i=branch(50.0, 35);
    if (i>fit)
    {
      fit=i;
      mt=get(0, 0, width, height);
    }
    popMatrix();
    image(mt, 0, 0);
    println(fit);
  }
  int branch(float len, float ang)
  {
    int step=0;
    float th=0;
    line(0, 0, 0, -len);
    translate(0, -len);
    len*=random(0.4, 1);
    int mod;
    if (len>2)
    {
      mod=int(random(8));
      if (mod==0)
      {
        pushMatrix();
        rotate(radians(random(0, ang)));
        step+=branch(len, ang+th);
        popMatrix();
      } else if (mod==1)
      {
        pushMatrix();
        rotate(radians(random(-ang, 0)));
        step+=branch(len, ang+th);
        popMatrix();
      } else
      {
        pushMatrix();
        rotate(radians(random(0, ang)));
        step+=branch(len, ang+th);
        step+=1;
        popMatrix();
        pushMatrix();
        rotate(radians(random(-ang, 0)));
        step+=branch(len, ang+th);
        step+=1;
        popMatrix();
      }
    }
    step+=1;
    return step;
  }
}