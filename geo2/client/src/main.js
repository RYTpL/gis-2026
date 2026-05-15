import './style.css';

import 'ol/ol.css';
import Map from 'ol/Map';
import View from 'ol/View';
import TileLayer from 'ol/layer/Tile';
import OSM from 'ol/source/OSM';

import ImageLayer from 'ol/layer/Image';
import ImageWMS from 'ol/source/ImageWMS';


const osmLayer = new TileLayer({
  source: new OSM()
});


const wmsLayer = new ImageLayer({
  source: new ImageWMS({
    url: 'http://localhost:8080/geoserver/gis/wms',
    params: {
      LAYERS: 'gis:buildings', // или gis:lab2_buildings — как у тебя назван слой
      TILED: true
    },
    ratio: 1,
    serverType: 'geoserver'
  })
});


const map = new Map({
  target: 'map',
  layers: [
    osmLayer,
    wmsLayer
  ],
  view: new View({
    center: [0, 0],
    zoom: 2
  })
});