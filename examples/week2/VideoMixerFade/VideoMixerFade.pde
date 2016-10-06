import processing.video.*;
import java.io.*;
import java.util.List;
import de.looksgood.ani.*;


List<Movie> movies = new ArrayList();
List<Movie> playingMovies = new ArrayList(); 

String keyOrder = "qwertyuiop[]\\asdfghjkl;'zxcvbnm,./";

void setup() {
  fullScreen(P3D);
  background(0);
  
  loadMovies();
}

/** Loads all of the movies in the sketch's data directory.
*/
void loadMovies(){
  File dataDir = new File(dataPath(""));
  File[] files = dataDir.listFiles();
  if (files == null){
    throw new RuntimeException("No data directory found in your processing sketch!");
  }
  for (File f : files){
     movies.add(new Movie(this, f.getAbsolutePath()));
  }
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(0);
  blendMode(ADD);
  for (Movie mov : playingMovies){
    image(mov, 0, 0, width, height); // draw first movie
  }
}

void keyPressed(){
  Movie m = getMovieForCurrentKey();
  if (m == null) return;
  if (!playingMovies.contains(m)){
    m.play();
    playingMovies.add(m);
  }
}

void keyReleased(){
  Movie m = getMovieForCurrentKey();
  if (m == null) return;
  m.pause();
  playingMovies.remove(m);
}


/** Gets a movie based on the current key that is pressed, based on the order
of keys in a QWERTY keyboard, starting with q
*/
Movie getMovieForCurrentKey(){
    int keyIndex = keyOrder.indexOf(key);
    
    if (keyIndex > movies.size()
        || keyIndex < 0)
          return null;
    return movies.get(keyIndex);
}