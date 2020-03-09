window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 5 || document.documentElement.scrollTop > 5) {
    if (document.getElementById("topbar") != null) document.getElementById("topbar").classList.add("bg-white");
  } else {
    if (document.getElementById("topbar") != null) document.getElementById("topbar").classList.remove("bg-white");
  }
}

let button = document.getElementById("mobile-button");

button.addEventListener("click", function() {
 document.getElementById("topbar").classList.toggle("bg-white");
});
