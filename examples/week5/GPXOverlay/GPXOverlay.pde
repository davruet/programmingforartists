/**
 * An application with a basic interactive map. You can zoom and pan the map.
 */

import de.fhpotsdam.unfolding.UnfoldingMap;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.marker.*;
import java.util.*;

UnfoldingMap map;

void setup() {
  fullScreen(P2D);

  map = new UnfoldingMap(this, new OpenStreetMap.OSMGrayProvider());
  map.zoomAndPanTo(18, new Location(44.048365f, -123.071582f));
  MapUtils.createDefaultEventDispatcher(this, map);
  
  List<Feature> features = GPXReader.loadData(this,"locations.gpx");
  MarkerFactory factory = new MarkerFactory();
  List<Marker> markers = factory.createMarkers(features);
  map.addMarkers(markers);
  map.setTweening(true);
}

void draw() {
  background(0); // important for when map tiles are pending / unavailable
  map.draw();
}

void mousePressed(){
  println(map.getLocation(mouseX, mouseY));  
}