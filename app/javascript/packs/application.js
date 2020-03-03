require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap";
import "../plugins/flatpickr"
import "../plugins/fanncy_btn"
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initMapbox } from '../plugins/init_mapbox';

initMapbox();

import { initOpenTaskOnClick } from '../components/tasks';
initOpenTaskOnClick();
