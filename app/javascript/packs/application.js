/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// require('@rails/ujs').start();
require('turbolinks').start();

require('jquery');
require('timeago');
require('bootstrap');
require('select2');
const stateMapUtils = require('./state_map_utils');

// Import our customized bootstrap styles
require('../stylesheets/application.scss');
// Use fontawesome icons improve page visuals
require('@fortawesome/fontawesome-free/css/all.css');

$(document).on('turbolinks:load', () => {
    jQuery.timeago.settings.allowPast = true;
    jQuery.timeago.settings.allowFuture = true;
    $('time.timeago').timeago();
    $('.actionmap-select2').select2({
        theme: 'bootstrap',
    });
    // const stateMapUtils = require('./state_map_utils');
    const stateMap = new stateMapUtils.Map();
    stateMapUtils.setupEventHandlers(stateMap);
});
