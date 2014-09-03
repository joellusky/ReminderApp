# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function() {
  $.simpleWeather({
    woeid: '2357536', //2357536
    location: '',
    unit: 'f',
    success: function(weather) {
      if(weather.temp > 75) {
        $('body').animate({backgroundColor: '#F7AC57'}, 1500);
      } else {
        $('body').animate({backgroundColor: '#0091c2'}, 1500);
      }
      html = '<h1 class="icon-'+weather.code+'"></h1>';
      html += '<h2>'+weather.temp+'&deg;</h2>';
      html += '<ul><li>'+weather.city+', '+weather.region+'</li>';
      html += '<li class="currently">'+weather.currently+'</li></ul>';
      //html += '<li>'+weather.tempAlt+'&deg;C</li></ul>';
      
      var timestamp = moment(weather.updated);
      html += '<p class="updated">Updated '+moment(timestamp).fromNow()+'</p>';
  
      $("#weather").html(html);
    },
    error: function(error) {
      $("#weather").html('<p>'+error+'</p>');
    }
  });
});
