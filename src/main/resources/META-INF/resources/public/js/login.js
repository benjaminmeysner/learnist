/**
 * Created by erustus on 19/04/17.
 */
var loader;
var formContainer;

$(document).ready(function() {
    loader = $('#loginLoader');
    formContainer = $('#login');
});
$(document).on('submit','#modalForm',function(){
    var disabled = $(this).find("button[type='submit']").hasClass('disabled');
    if (!disabled){
        formContainer.hide();
        loader.show();
        $.post($(this).attr('action'), $(this).serialize(), function(res, status, xhr){
            if (xhr.getResponseHeader('Redirect')) {
                // data.redirect contains the string URL to redirect to
                window.location.href = xhr.getResponseHeader('Redirect');
            }
            else {
                $('#formContainer').replaceWith(res);
                $('#modalForm').validator();
                loader.hide();
                formContainer.show();
            }
        });
    }
    return false;
});

$(document).on('click','.close-login',function(){

    if ($(this).attr('aria-label')) {
        $('#loginModal').modal('hide');
    }
    $.get("/login/close", function(res){
        $('#formContainer').replaceWith(res);
        $('#modalForm').validator();
    });
    return false;
});
function forgot() {
    formContainer.hide();
    loader.show();
    $.get("/login/forgot-password", function(res){
        $('#formContainer').replaceWith(res);
        $('#modalForm').validator();
        loader.hide();
        formContainer.show();
    });
    return false;
};