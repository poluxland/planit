window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 5 || document.documentElement.scrollTop > 5) {
    if (document.getElementById("topbar") != null) document.getElementById("topbar").classList.add("nav-white");
  } else {
    if (document.getElementById("topbar") != null) document.getElementById("topbar").classList.remove("nav-white");
  }
}

let button = document.getElementById("mobile-button");

button.addEventListener("click", function() {
 document.getElementById("topbar").classList.add("nav-white");
});
