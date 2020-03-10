import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('input-0');
  if (addressInput) {
    places({
      appId: 'plDZQY8F8SRD',
      apiKey: 'ed238104cbd48ccfdfbd3c9f2ae81ae8',
      container: addressInput })
      .configure({
        language: 'en'
      });
  }
};

export { initAutocomplete };

const initAutocompletes = () => {
  const addressInput = document.getElementById('input-00');
  if (addressInput) {
    places({
      appId: 'plDZQY8F8SRD',
      apiKey: 'ed238104cbd48ccfdfbd3c9f2ae81ae8',
      container: addressInput })
      .configure({
        language: 'en'
      });
  }
};

export { initAutocompletes };


  // (function() {
  //   var placesAutocomplete = places({
  //     appId: 'plDZQY8F8SRD',
  //     apiKey: 'ed238104cbd48ccfdfbd3c9f2ae81ae8',
  //     container: document.querySelector('#address')
  //   });

  //   var $address = document.querySelector('#input-0')
  //   placesAutocomplete.on('change', function(e) {
  //     $address.textContent = e.suggestion.value
  //   });

  //   placesAutocomplete.on('clear', function() {
  //     $address.textContent = 'none';
  //   });

  // })();



