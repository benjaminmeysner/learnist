/*****
 * CONFIGURATION
 */
//Main navigation
$.navigation = $('nav > ul.nav');

$.panelIconOpened = 'icon-arrow-up';
$.panelIconClosed = 'icon-arrow-down';

//Default colours
$.brandPrimary =  '#20a8d8';
$.brandSuccess =  '#4dbd74';
$.brandInfo =     '#63c2de';
$.brandWarning =  '#f8cb00';
$.brandDanger =   '#f86c6b';

$.grayDark =      '#2a2c36';
$.gray =          '#55595c';
$.grayLight =     '#818a91';
$.grayLighter =   '#d1d4d7';
$.grayLightest =  '#f8f9fa';

var main = $('#main');
'use strict';

/****
 * MAIN NAVIGATION
 */

$(document).ready(function($){
    $('#pageLoader').toggle();
    // Add class .active to current link
    $.navigation.find('a').each(function(){

        var cUrl = String(window.location).split('?')[0];

        if (cUrl.substr(cUrl.length - 1) == '#') {
            cUrl = cUrl.slice(0,-1);
        }

        if ($($(this))[0].href==cUrl) {
            $(this).addClass('active');

            $(this).parents('ul').add(this).each(function(){
                $(this).parent().addClass('open');
            });
        }
    });

    // Dropdown Menu
    $('.nav-dropdown-toggle').on('click', function(){
        $(this).parent().toggleClass('open');
        resizeBroadcast();
    });

    function resizeBroadcast() {

        var timesRun = 0;
        var interval = setInterval(function(){
            timesRun += 1;
            if(timesRun === 5){
                clearInterval(interval);
            }
            window.dispatchEvent(new Event('resize'));
        }, 62.5);
    }

    /* ---------- Main Menu Open/Close, Min/Full ---------- */
    $('.navbar-toggler').click(function(){

        if ($(this).hasClass('sidebar-toggler')) {
            $('body').toggleClass('sidebar-hidden');
            resizeBroadcast();
        }

        if ($(this).hasClass('aside-menu-toggler')) {
            $('body').toggleClass('aside-menu-hidden');
            resizeBroadcast();
        }

        if ($(this).hasClass('mobile-sidebar-toggler')) {
            $('body').toggleClass('sidebar-mobile-show');
            resizeBroadcast();
        }

    });

    $('.sidebar-close').click(function(){
        $('body').toggleClass('sidebar-opened').parent().toggleClass('sidebar-opened');
    });

    /* ---------- Disable moving to top ---------- */
    $('a[href="#"][data-top!=true]').click(function(e){
        e.preventDefault();
    });

});

/****
 * CARDS ACTIONS
 */
$(document).on('click','#toggleSearchDiv',function() {
    $('#toggleSearch').toggle();
    $('.searchSubmit').toggle();
    var chevron = $('#searchChevron');
    if (chevron.hasClass('fa-chevron-down')){
        chevron.removeClass('fa-chevron-down');
        chevron.addClass('fa-chevron-up');
    }
    else {
        chevron.removeClass('fa-chevron-up');
        chevron.addClass('fa-chevron-down');
        $('#searchRole').val("");
        $('#searchStatus').val("");
        $('#searchStatus option').prop('selected',true);
        $('#searchActivatedTrue,#searchActivatedFalse').prop('checked',false);
    }
});
$(document).on('click', '#toggleSearchDiv2',function() {
    $('#toggleSearch2').toggle();
    $('.searchSubmit2').toggle();
    var chevron =$('#searchChevron2');
    if (chevron.hasClass('fa-chevron-down')){
        chevron.removeClass('fa-chevron-down');
        chevron.addClass('fa-chevron-up');
    }
    else {
        chevron.removeClass('fa-chevron-up');
        chevron.addClass('fa-chevron-down');
        $('#searchStatus2').val("");
        $('#searchTags').val("");
        $('#searchSubject option').prop('selected',true);
    }
});

$(document).on('click', '.card-actions a', function(e){
    e.preventDefault();

    if ($(this).hasClass('btn-close')) {
        $(this).parent().parent().parent().fadeOut();
    } else if ($(this).hasClass('btn-minimize')) {
        var $target = $(this).parent().parent().next('.card-block');
        if (!$(this).hasClass('collapsed')) {
            $('i',$(this)).removeClass($.panelIconOpened).addClass($.panelIconClosed);
        } else {
            $('i',$(this)).removeClass($.panelIconClosed).addClass($.panelIconOpened);
        }

    } else if ($(this).hasClass('btn-setting')) {
        $('#myModal').modal('show');
    }

});

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function init(url) {

    /* ---------- Tooltip ---------- */
    $('[rel="tooltip"],[data-rel="tooltip"]').tooltip({"placement":"bottom",delay: { show: 400, hide: 200 }});

    /* ---------- Popover ---------- */
    $('[rel="popover"],[data-rel="popover"],[data-toggle="popover"]').popover();

}
/****
 * ASYNC Page loading
 */
$(document).on('click','.nav-page',function(){
    $('.modal-backdrop').hide();
    $('body').toggleClass('sidebar-mobile-show');
    var url = $(this).attr('href');
    if (url != '#'){
        var loader = $('#pageLoader');
        var form = $('#navForm');
        var link = $(this);
        var title = link.data('title');
        main.hide();
        loader.show();
        $.ajax({
            url: url,
            type: 'POST',
            data: $(form).serialize(),
            success: function(data){
                $('.sidebar').find('.active').removeClass('active');
                $(link).addClass('active');
                $('#adminContainer').replaceWith(data);
                window.history.pushState({url: "" + url + ""}, "test", url);
                if (!title){
                    title = $(link).text().substr(1);
                }
                $('title').text(title);
                $('form[data-toggle=validator]').validator();
                loader.hide();
                main.show();
            },
            error: function() {
                loader.hide();
                main.show();
            }
        });
    }
    return false;
});

$(document).on('click','.user-page-link',function(){
    $('.modal-backdrop').hide();
    var url = $(this).attr('href');
    var loader = $('#pageLoader');
    var link = $(this);
    var  username = link.text();
    main.hide();
    loader.show();
    $.ajax({
        url: url,
        type: 'GET',
        success: function(data){
            $('.sidebar').find('.active').removeClass('active');
            $('#adminContainer').replaceWith(data);
            console.log(username);
            window.history.pushState({url: "/administrator/user/" + username }, "test", url);
            $('title').text(username);
            $('form[data-toggle=validator]').validator();
            loader.hide();
            main.show();
        },
        error: function() {
            loader.hide();
            main.show();
        }
    });
    return false;
});

$(document).on('click', '.approval', function () {
    var form = $(this).closest('form');
    var formData = form.serializeArray();
    formData.push({ name: this.name, value: this.value });

    $(this).closest('#suspendModal').modal('hide');
    $(this).closest('#deleteModal').modal('hide');
    var loader = $('#pageLoader');
    var cont = main;
    var data = $('#adminContainer');
    $.post(form.attr('action'), formData ,function(res){
        data.replaceWith(res);
        $('form[data-toggle=validator]').validator();
        loader.hide();
        cont.show();
    });
    return false;

});
$(document).on('submit','.user-page-form',function(e){
    var loader;
    var cont;
    var data;
    $('.modal-backdrop').hide();
    if ($(this).attr('id') == 'userSearch'){
        loader = $('#searchLoader');
        data = $('#searchTable');
        cont = data.closest('.table-cont');
    }
    else if ($(this).hasClass('user-card-form')){
        loader = $(this).closest('.card-block').find('.load-cont');
        data = $(this).closest('.form-table');
        cont = data.closest('.table-cont');
    }
    else{
        $(this).closest('#suspendModal').modal('hide');
        $(this).closest('#deleteModal').modal('hide');
        loader = $('#pageLoader');
        cont = main;
        data = $('#adminContainer');
    }
    cont.hide();
    loader.show();
    $.post($(this).attr('action'), $(this).serialize() ,function(res){
        data.replaceWith(res);
        $('form[data-toggle=validator]').validator();
        loader.hide();
        cont.show();
    });
    return false;
});

$(document).on('click','.paginate-btn',function(){
    var pager = $(this);
    var table = pager.closest('.pagination-table');
    var form = pager.closest('form');
    var loader = form.closest('.card-block').find('.load-cont');
    var tableCont = table.closest('.table-cont');
    tableCont.hide();
    loader.show();

    $.post(form.attr('action'), {pageNumber:pager.val(), _csrf: $(table.find('input[name=_csrf]')).val()} ,function(res){
        table.replaceWith(res);
        loader.hide();
        tableCont.show();
    });
    return false;
});

var viewPdf = function(username) {
    $('.applicationToggle').toggle();
    $('#applicationFrame').attr('src','/public/js/viewerjs/index.html#http://learnist.s3.amazonaws.com/'+env+'/administrator/application/'+username+'.pdf');
    $('#applUser').attr('value',username);
};

$(document).on('click','.msg-btn', function () {
    var modal = $('#messageModal');
    $(modal.find('input')[0]).val($(this).data('value'));
});

$(document).on('click', '.pass-tog', function () {
    $('.pass-edit').toggle();
} );

gapi.analytics.ready(function() {

    /**
     * Authorize the user immediately if the user has already granted access.
     * If no access has been created, render an authorize button inside the
     * element with the ID "embed-api-auth-container".
     */
    gapi.analytics.auth.authorize({
        container: 'embed-api-auth-container',
        clientid: '103022290801-u87ta79gl3e1m1brkp8a3dof6tlo6uqj.apps.googleusercontent.com'
    });


    /**
     * Create a new ViewSelector instance to be rendered inside of an
     * element with the id "view-selector-container".
     */
    var viewSelector = new gapi.analytics.ViewSelector({
        container: 'view-selector-container'
    });

    // Render the view selector to the page.
    viewSelector.execute();




    /**
     * Create a new DataChart instance with the given query parameters
     * and Google chart options. It will be rendered inside an element
     * with the id "chart-container".
     */
    var dataChart = new gapi.analytics.googleCharts.DataChart({
        query: {
            metrics: 'ga:sessions',
            dimensions: 'ga:date',
            'start-date': '30daysAgo',
            'end-date': 'yesterday'
        },
        chart: {
            container: 'chart-container',
            type: 'LINE',
            options: {
                width: '100%'
            }
        }
    });

    var dataChart1 = new gapi.analytics.googleCharts.DataChart({
        query: {
            metrics: 'ga:sessions',
            dimensions: 'ga:country',
            'start-date': '30daysAgo',
            'end-date': 'yesterday',
            'max-results': 6,
            sort: '-ga:sessions'
        },
        chart: {
            container: 'chart-1-container',
            type: 'PIE',
            options: {
                width: '100%',
                pieHole: 4/9
            }
        }
    });

    var entranceTable = new gapi.analytics.googleCharts.DataChart({
            query: {
                metrics: ['ga:entrances','ga:bounces'],
                dimensions: 'ga:landingPagePath',
                'start-date': '90daysAgo',
                'end-date': 'yesterday',
                sort: '-ga:entrances',
                'max-results': '10'
            },
            chart: {
                container: 'entrance-container',
                type: 'TABLE',
                options: {
                    width: '100%'
                }
            }
    });

    /**
     * Render the dataChart on the page whenever a new view is selected.
     */
    viewSelector.on('change', function(ids) {
        dataChart.set({query: {ids: ids}}).execute();
        entranceTable.set({query: {ids: ids}}).execute();
    });

});