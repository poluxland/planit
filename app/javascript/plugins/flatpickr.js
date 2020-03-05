

// import flatpickr from "flatpickr"

// import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

// flatpickr("#range_start", {
//    // altInput: true,
//    inline: true,
//    altInputClass : "invisible",
//    // minDate: "today",
//    plugins: [new rangePlugin({ input: "#range_end"})]
//  })




import flatpickr from "flatpickr"
// import "flatpickr/dist/flatpickr.min.css"
// import "flatpickr/dist/themes/material_blue.css"
import "flatpickr/dist/themes/airbnb.css"
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"


  flatpickr("#range_start", {
    //altInput: true,
    inline: true,
    altInputClass : "invisible",
    minDate: "today",
    plugins: [new rangePlugin({ input: "#range_end"})]

  })
