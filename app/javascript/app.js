function app(){
  M.AutoInit();

  var sidenav = document.querySelectorAll('.sidenav');
  var sidenavInstance = M.Sidenav.init(sidenav, {
    "edge" : "right"
  });

  // var slider = document.querySelectorAll('.slider');
  //   var sliderInstances = M.Slider.init(slider, {
  //   });

}
window.addEventListener("load", app);


