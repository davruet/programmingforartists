/**
 * An application with a basic interactive map. You can zoom and pan the map.
 */

import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;


import java.util.List;
import java.io.File;

List<AbstractMapProvider> providers = new ArrayList();

UnfoldingMap map;
PShader shader;

void setup() {
  size(800, 600, P2D);
  //fullScreen(P2D);
  map = new UnfoldingMap(this, new Microsoft.AerialProvider());
  map.zoomAndPanTo(10, new Location(45.0f, -110.0f));
  MapUtils.createDefaultEventDispatcher(this, map); //<>// //<>//
}


void draw() {
  map.draw();
  map.panBy(.5f,0);
}