$(document).on('change','.file-upload',function(){
    var span = $(this).parent().find('span');
    span.attr('data-filename',$(this)[0].files.item(0).name)
});
$(document).on('click','.clickable-row',function(){
    window.location = $(this).data("href");
});
$('.toggle-edit').on('click',function() {
    toggleEdit($(this));
});

$('.toggle-cancel').on('click', function () {
    toggleEdit($(this));
});


function toggleEdit(e) {
    $(e.data('target')).toggle();
}

var last = null;

$('#tags').change(function() {

    if ($(this).val().length > 5) {

        $(this).val(last);
    } else {
        last = $(this).val();
    }
});

$(document).on('click','.paginate-btn',function(){
    var pager = $(this);
    var table = pager.closest('.pagination-table');
    var form = pager.closest('form');
    var loader = form.closest('.card-block').find('.load-cont');
    var tableCont = table.closest('.table-cont');
    tableCont.hide();
    loader.show();
    var datar = {pageNumber:pager.val(), _csrf: $(table.find('input[name=_csrf]')).val()};
    console.log(datar);
    $.post(form.attr('action'), datar ,function(res){
        table.replaceWith(res);
        loader.hide();
        tableCont.show();
    });
    return false;
});

$('#autoSearch').submit(function (e) {
    e.preventDefault();
    console.log($(this));
    var code = $('#mainSearch').val();
    if(code){
        code = "/" + code;
    }
    window.location = $(this).attr('action')+code;
    return false;

});

var mainSearch = $('#mainSearch').autocomplete({
    source: function (request, response) {
        $.ajax({
            url: "/course/search/autocomplete",
            data: {
                search: request.term
            },
            success: function (data) {
                response(JSON.parse(data));
            }
        });

    },
    appendTo: "#navSearch",
    minLength: 2,
    messages: {
        noResults: '',
        results: function() {}
    },
    select: function (event, ui) {
        window.location = "/course/"+ui.item.value;
        return false;
    }
}).data('ui-autocomplete');

var mainSearch2 = $('#mainSearch2').autocomplete({
    source: function (request, response) {
        $.ajax({
            url: "/course/search/autocomplete",
            data: {
                search: request.term
            },
            success: function (data) {
                response(JSON.parse(data));
            }
        });

    },
    appendTo: "#navSearch2",
    minLength: 2,
    messages: {
        noResults: '',
        results: function() {}
    },
}).data('ui-autocomplete');

mainSearch._resizeMenu = function () {
    this.menu.element.outerWidth($('#mainSearchCont').css('width'));
};
mainSearch._renderItem = function (ul, item) {
    return $("<a>")
        .attr("href","/course/"+item.value)
        .attr("class","list-group-item list-group-item-action")
        .append(item.label)
        .appendTo(ul);
};

$('#mainSearch').bind("autocompletefocus", function (event, ui) {
    $(event.target).val(ui.item.label);
    return false;
});

$('#mainSearch').bind("autocompleteselect", function (event, ui) {
    $(event.target).val(ui.item.label);
    return false;
});

mainSearch2._resizeMenu = function () {
    this.menu.element.outerWidth($('#mainSearchCont2').css('width'));
};
mainSearch2._renderItem = function (ul, item) {
    return $("<li>")
        .attr("class","list-group-item list-group-item-action")
        .append(item.label)
        .appendTo(ul);
};

$('#mainSearch2').bind("autocompletefocus", function (event, ui) {
    $(event.target).val(ui.item.label);
    return false;
});

$('#mainSearch2').bind("autocompleteselect", function (event, ui) {
    $(event.target).val(ui.item.label);
    return false;
});
$(document).ready(function () {
   $('#content').find('video').attr('poster','');
});

$(document).on('click','.read-notification', function () {
    var val = $(this).data('val');
    $(this).closest('li').remove();
    $('.read-no').text($('.read-no').text()[0] - 1)
    var form = $('#notificationForm');
    console.log(form);
    var formData = form.serializeArray();
    formData.push({ name: "id", value: val });
    $.post(form.attr('action'),formData,function (data) {
        console.log(data);
    });
});

$(document).on('click', '.pass-tog', function () {
    $('.pass-edit').toggle();
} );

$(document).on('submit','#meetupForm', function (e) {
    var form = $(this);
    date = moment($('#newDate').val()).format('DD/MM/YYYY HH:mm');
    $('#newDate').attr('type','text');
    $('#newDate').attr('value',date);
    $('#newDate').val(date);
    console.log(date);
});