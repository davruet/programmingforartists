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

  map = new UnfoldingMap(this, new MapBox.BlankProvider());
  map.zoomAndPanTo(18, new Location(44.048365f, -123.071582f));
  MapUtils.createDefaultEventDispatcher(this, map);
  
  List<Feature> features = GeoJSONReader.loadData(this,"rivers.geojson");
  
  MarkerFactory factory = new MarkerFactory();
  List<Marker> markers = factory.createMarkers(features);
  map.addMarkers(markers);
  map.setTweening(true);
}

void draw() {
  background(255); // important for when map tiles are not drawn
  map.draw();
}

void mousePressed(){
  println(map.getLocation(mouseX, mouseY));  
}