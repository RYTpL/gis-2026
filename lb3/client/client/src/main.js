import './style.css';

import 'ol/ol.css';
import Map from 'ol/Map';
import View from 'ol/View';
import TileLayer from 'ol/layer/Tile';
import OSM from 'ol/source/OSM';

import VectorLayer from 'ol/layer/Vector';
import VectorSource from 'ol/source/Vector';
import GeoJSON from 'ol/format/GeoJSON';

import Style from 'ol/style/Style';
import Fill from 'ol/style/Fill';
import {useGeographic} from 'ol/proj';

useGeographic();

document.querySelector('#app').innerHTML = `
  <div id="map"></div>
`;

const osmLayer = new TileLayer({
  source: new OSM()
});

const overtureSource = new VectorSource({
  url: '/overture.geojson',
  format: new GeoJSON()
});

const overtureLayer = new VectorLayer({
  source: overtureSource,
  style: feature => {
    const sourceType = feature.get('source_type');
    let color = '#888888';
    if (sourceType === 'ml') color = 'rgba(255,153,0,0.7)';
    else if (sourceType === 'osm') color = 'rgba(0,102,255,0.7)';
    else if (sourceType === 'my') color = 'rgba(0,170,85,0.8)';

    return new Style({
      fill: new Fill({color})
    });
  }
});

const map = new Map({
  target: 'map',
  layers: [osmLayer, overtureLayer],
  view: new View({
    center: [0, 0],
    zoom: 2
  })
});

overtureSource.on('change', () => {
  if (overtureSource.getState() === 'ready') {
    const extent = overtureSource.getExtent();
    if (extent && isFinite(extent[0])) {
      map.getView().fit(extent, {padding: [20, 20, 20, 20]});
    }
  }
});