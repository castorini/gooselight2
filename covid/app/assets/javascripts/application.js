//= require jquery
//= require jquery3
//= require rails-ujs
//= require turbolinks
//
// Required by Blacklight
//= require popper
// Twitter Typeahead for autocomplete
//= require twitter/typeahead
//= require bootstrap
//= require blacklight/blacklight
//= require feather-icons

$(document).on('turbolinks:load', function() {
    $(function(){ feather.replace(); });
});
  