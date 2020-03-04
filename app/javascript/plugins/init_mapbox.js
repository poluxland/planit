import mapboxgl from 'mapbox-gl';

const mapElement = document.getElementById('map');

const buildMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/benbenisuper/ck7ddd5hb0gl81io0t1h1bcrz'
  });
};

const addMarkersToMap = (map, markers, center) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);


    const newMarker = new mapboxgl.Marker()
    .setLngLat([ marker.lng, marker.lat ])
    .setPopup(popup)
    .addTo(map)


    newMarker.getElement().addEventListener('click', (e) => {
      console.log(newMarker.getElement())
      map.flyTo({ center: [ marker.lng, marker.lat + 2], zoom:5});
    })
    console.log(center)
    popup.on('close', function(e) {
     map.flyTo({ center: [center._sw.lng +40, center._ne.lat - 20], zoom:2});
    })

  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 2 });
  return bounds;
};

const initMapbox = () => {
  if (mapElement) {
    const map = buildMap();
    const markers = JSON.parse(mapElement.dataset.markers);
    const center = fitMapToMarkers(map, markers);
    addMarkersToMap(map, markers, center);
  }
};


export { initMapbox };

