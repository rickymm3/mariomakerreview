// This is a manifest file that'll be compiled into including all the files listed below.
// // Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// // be included in the compiled file accessible from http://example.com/assets/application.js
// // It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// // the compiled file.
// //
//= require jquery
//= require jquery.minicolors
//= require jquery.minicolors.simple_form
//= require jquery_ujs
//= require twitter/bootstrap
//= require ckeditor-jquery
//= require jquery.infinitescroll
//= require_tree ./ckeditor
//= require cliqs
// //= require_tree .

$( document ).ready(function() {

    $('.cliq-info-hover').hover(function() {
        var string
        string = '.cliq-info-'+$(this).data('cliq-id')
        console.log(string)
        $(string).toggle()
    });

    $('.ckeditor').ckeditor({
        // optional config
    });

    $('.cliq-small').hover(
        function() {
            var inner = $(this).find('.cliq-hidden')
            inner.addClass('cliq-active')
        }, function() {
            var inner = $(this).find('.cliq-hidden')
            inner.removeClass('cliq-active')
    });


// ---
// generated by coffee-script 1.9.2

});

