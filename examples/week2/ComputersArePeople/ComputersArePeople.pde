import processing.video.*;

Movie mov, mov2;

void setup() {
  fullScreen(P3D);
  background(0);

  mov = new Movie(this, "computersArePeople.mp4");
  mov2 = new Movie(this, "OnGuard1956_edit.mp4");
  
  // Pausing the video at the first frame. 
  mov.play();
  mov2.play();
  mov.loop();
  mov2.loop();
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
    // Decide which movie to draw this frame, 50/50 chance one or the other
    float whichMovie = random(1);
    
    if (whichMovie > .5){
      image(mov, 0, 0, width, height); // draw first movie
    } else {
      image(mov2, 0, 0, width, height); // draw second movie
    }
   
    /// jump around - 1 in 100 chance each frame of jumping to a random location in one movie
    jumpRandom(mov);
    jumpRandom(mov2);
}

/** Jump to a random point in the movie approximately 1 in 100 times this method is called
*/
void jumpRandom(Movie mov){
  if (random(100) < 1) mov.jump(random(0, mov.duration()));
}