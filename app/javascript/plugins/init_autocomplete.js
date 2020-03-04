import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('input-0');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };

const initAutocompletes = () => {
  const addressInput = document.getElementById('input-00');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocompletes };
