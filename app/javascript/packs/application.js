require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")


import "bootstrap";
import "../plugins/flatpickr";
import "../plugins/fanncy_btn";
import "../plugins/scroll";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import "../plugins/flatpickr"
import '../components/tasks';

import { initAutocompletes } from "../plugins/init_autocomplete";
import { initAutocomplete } from "../plugins/init_autocomplete";
import { initOpenTaskOnClick } from '../components/tasks';
import { initMapbox } from '../plugins/init_mapbox';
import { scrollLastMessageIntoView } from '../components/scroll';




initAutocomplete();
initAutocompletes();
initMapbox();
initOpenTaskOnClick();
window.scrollLastMessageIntoView = scrollLastMessageIntoView;
