// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import '../css/application.css'

import 'alpinejs'

const Choices = require('choices.js')
document.addEventListener("turbolinks:load", function() {
    var dropDownSelects = new Choices('#infector-select')
})

// Include Inter Typeface
import 'typeface-inter'

// Turbolinks Reset Scroll
Turbolinks.scroll = {};
document.addEventListener("turbolinks:load", () => {

    const elements = document.querySelectorAll("[data-turbolinks-scroll]");
    elements.forEach(function(element) {

        element.addEventListener("click", () => {
            Turbolinks.scroll['top'] = document.scrollingElement.scrollTop;
        });

        element.addEventListener("submit", () => {
            Turbolinks.scroll['top'] = document.scrollingElement.scrollTop;
        });

    });

    if (Turbolinks.scroll['top']) {
        document.scrollingElement.scrollTo(0, Turbolinks.scroll['top']);
        console.log(Turbolinks.scroll['top'])
    }

    Turbolinks.scroll = {};
});

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
