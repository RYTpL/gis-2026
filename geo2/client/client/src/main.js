import './style.css';

import 'ol/ol.css';
import Map from 'ol/Map';
import View from 'ol/View';
import TileLayer from 'ol/layer/Tile';
import OSM from 'ol/source/OSM';

import ImageLayer from 'ol/layer/Image';
import ImageWMS from 'ol/source/ImageWMS';

// Вставляем HTML
document.querySelector('#app').innerHTML = `
  <main>
    <div id="map"></div>
  </main>
`;

// Базовый слой OSM
const osmLayer = new TileLayer({
  source: new OSM()
});

// Создаём карту
const map = new Map({
  target: 'map',
  layers: [osmLayer], // пока только OSM
  view: new View({
    center: [0, 0],
    zoom: 2
  })
});

// WMS-слой из GeoServer — ДОБАВЛЯЕМ СЮДА
const wmsLayer = new ImageLayer({
  source: new ImageWMS({
    url: 'http://localhost:8080/geoserver/gis/wms',
    params: {
      LAYERS: 'gis:buildings', // имя слоя, который опубликовал в GeoServer
      TILED: true
    },
    ratio: 1,
    serverType: 'geoserver'
  })
});

// Подключаем WMS-слой к карте
map.addLayer(wmsLayer);