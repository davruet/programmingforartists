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
Table table;

void setup() {
  fullScreen(P2D);

  map = new UnfoldingMap(this);
  map.zoomAndPanTo(18, new Location(43.971f, -122.866));
  MapUtils.createDefaultEventDispatcher(this, map);
  
  List<Feature> features = GeoJSONReader.loadData(this,"NHDArea.json");
  MarkerFactory factory = new MarkerFactory();
  List<Marker> markers = factory.createMarkers(features);
  
  for (Marker m: markers){
      color c = color(255,0,0);
      m.setColor(c);
  }
  map.addMarkers(markers);
  map.setTweening(true);
  
  table = loadTable("coordinates.csv", "header");

  println(table.getRowCount() + " total rows in table"); 

  for (TableRow row : table.rows()) {
    
    float lat = row.getFloat("Latitude");
    float lon = row.getFloat("Longitude");
    Location loc = new Location(lat, lon);
    SimplePointMarker marker = new SimplePointMarker(loc);
    marker.setColor(color(255,0,0));
    map.addMarker(marker);
  }
 
  
}

Iterator<Location> it;

void draw() {
  background(255); // important for when map tiles are not drawn
  map.draw();
}

void mousePressed(){
  println(map.getLocation(mouseX, mouseY));  
}