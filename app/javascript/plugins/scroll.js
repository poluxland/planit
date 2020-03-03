window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 5 || document.documentElement.scrollTop > 5) {
    if (document.getElementById("topbar") != null) document.getElementById("topbar").classList.add("bg-white");
  } else {
    if (document.getElementById("topbar") != null) document.getElementById("topbar").classList.remove("bg-white");
  }
}
