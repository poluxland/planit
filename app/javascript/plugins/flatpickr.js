

import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css"
// import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

// flatpickr("#range_start", {
//   altInput: true,
//   inline: true,
//   altInputClass : "invisible",
//   minDate: "today",
//   plugins: [new rangePlugin({ input: "#range_end"})]
// })

flatpickr(".datepicker", {
  allowInput: true,
  inline: true,
  altInputClass : "invisible"

})
