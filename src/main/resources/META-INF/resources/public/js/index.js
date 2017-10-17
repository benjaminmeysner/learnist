function toggleLogin() {
    $('#loginModal').modal('toggle');
}
(function($) {
    "use strict"; // Start of use strict

    // jQuery for page scrolling feature - requires jQuery Easing plugin
    $('a.page-scroll').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: ($($anchor.attr('href')).offset().top - 50)
        }, 1250, 'easeInOutExpo');
        event.preventDefault();
    });

    // Highlight the top nav as scrolling occurs
    $('body').scrollspy({
        target: '.navbar-fixed-top',
        offset: 51
    });

    // Closes the Responsive Menu on Menu Item Click
    $('.navbar-collapse ul li a').click(function(){
        $('.navbar-toggle:visible').click();
    });

    var a = $("#courses").offset().top - 100;

    $(document).scroll(function(){
        if($(this).scrollTop() > a)
        {
            $('.nav li a').css({"color":"#000000"});
            $('.gibson-four').css({"background-color":"#969696"});
            $('#mainSearchCont').removeClass("scroll");
        } else {
            $('.nav li a').css({"color":"#969696"});
            $('.gibson-four').css({"background-color":"transparent"});
            $('#mainSearchCont').addClass("scroll");
        }
    });

})(jQuery); // End of use strict
