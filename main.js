import './style.css';
import {Map, View} from 'ol';
import TileLayer from 'ol/layer/Tile';
import OSM from 'ol/source/OSM';
import {fromLonLat} from "ol/proj";
import VectorLayer from "ol/layer/Vector";
import VectorSource from "ol/source/Vector";
import {GeoJSON} from "ol/format";
import {Fill, Stroke, Style, Text} from "ol/style";
import {Tile} from "ol/layer";
import {XYZ} from "ol/source";

const  placesLayer = new VectorLayer({
  source: new VectorSource({
    url: './places.json',
    format: new GeoJSON(),
  }),
  style: (feature) =>
      new Style({
        text: new Text({
          text: feature.get('name'),
          fill: new Fill({
            color: '#f00'
          }),
          stroke: new Stroke({
            color: [255, 255, 255, 0.8],
            width: 2
          }),
          font: '12px Courier, shmulik, Helvetica Neue, Arial'
        })
      })
});

const map = new Map({
  target: 'map',
  layers: [
    // new TileLayer({
    //   source: new OSM()
    // }),
      new Tile({
        source: new XYZ({
          url: 'http://services.arcgisonline.com/arcgis/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}'
        })
      }),
    placesLayer,

  ],
  view: new View({
    center: fromLonLat([43.027307, 34.324279]),
    maxZoom: 19,
    zoom: 6,
  })
});
