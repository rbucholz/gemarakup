import './style.css';
import {Map, View} from 'ol';
import {fromLonLat} from "ol/proj";
import VectorLayer from "ol/layer/Vector";
import VectorSource from "ol/source/Vector";
import {GeoJSON} from "ol/format";
import {Fill, Stroke, Style, Text} from "ol/style";
import {Tile} from "ol/layer";
import {XYZ} from "ol/source";

const  placesLayer = new VectorLayer({
  source: new VectorSource({
    url: './data/places.json',
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
          font: '10pt shmulik, serif',
        })
      })
});

const map = new Map({
  target: 'map',
  layers: [
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
    zoom: 7,
  }),
});

const onFeatureClick = ($event) => {
    const feature = map.forEachFeatureAtPixel($event.pixel, (feature, layer) => feature);
    if (feature) {
        const coordinates = feature.getGeometry().getCoordinates();
        map.getView().animate({center: coordinates, zoom: 15});
        // alert(feature.get('id'));
    }
};

map.on('click', onFeatureClick);