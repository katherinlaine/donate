$(function() {
  L.mapbox.accessToken = MAPBOX_ACCESS_TOKEN
  var map = L.mapbox.map('map', MAPBOX_MAP_ID, {
    maxZoom: 16
  }).setView([40.738, -73.902], 12);

  function addMarkers() {
    var agencyData = $('#map').data('markers');
    var markers = L.mapbox.featureLayer(agencyData);
    markers.addTo(map)

    setTimeout(function () {
      map.fitBounds(markers.getBounds());
    }, 0);
  }

  addMarkers();
});
