class Button
{
  private int x, y, width, height;
  private PFont font;
  private String label;
  private int fontSize;

  public Button(int x, int y, int width, int height, String label, int fontSize)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.font = createFont("Arial", 16, true);
    this.fontSize = fontSize;
    this.label = label;
  }

  public void Draw()
  {
    fill(255);
    stroke(0);
    rect(x, y, width, height);
    textFont(font, fontSize);
    noStroke();
    fill(0);
    text(label, x + 5, y + (height - fontSize) / 2 + (height / 2));
  }

  public boolean IsPressed()
  {    
    if (!mousePressed)
    {
      return false;
    }

    if (mouseX >= x && mouseX <= x + width)
    {
      if (mouseY >= y && mouseY <= y + (height))
      {
        return true;
      }
    }

    return false;
  }
}