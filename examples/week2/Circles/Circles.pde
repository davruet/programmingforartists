
ArrayList<Circle> circles = new ArrayList();

void setup(){
  size(640, 480, P2D);
  for (int i = 0; i < 1000; i++ ){
    circles.add(new Circle());
  
  }
  
}

public void draw(){
  background(0);
  
  for (Circle c : circles){
      c.draw();
  }
  
}


class Circle {
  
  float radius = 10;
  float x = random(0, width);
  float y = random(0, height);
  float velocityX = random(1, 2);
  float velocityY = random(1, 2);
  
  
  void draw(){
    ellipse(x, y, radius * 2,radius * 2);
    x += velocityX; // x = x + velocity;
    y += velocityY;
    
    if (x < 0) velocityX *= -1;
    if (x > width) velocityX *= -1;
    
    if (y < 0) velocityY *= -1;
    if (y > height) velocityY *= -1;
    
  }
  
}