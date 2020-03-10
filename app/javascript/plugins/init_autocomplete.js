import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('input-0');
  if (addressInput) {
    places({ container: addressInput })
      .configure({
        language: 'en'
      });
  }
};

export { initAutocomplete };

const initAutocompletes = () => {
  const addressInput = document.getElementById('input-00');
  if (addressInput) {
    places({ container: addressInput })
      .configure({
        language: 'en'
      });
  }
};

export { initAutocompletes };
