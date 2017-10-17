/**
 * Created by dani1 on 17/04/2017.
 */
$(document).on('submit','#confirmKeyForm',function(){
    var alert = $('#key_status');
    $.ajax({
        type: 'POST',
        url: $(this).attr('action'),
        data: $(this).serialize(),
        success: function(response){
            console.log(response);
            $('#confirmKeyForm').remove();
            if (response == "/register/lecturer/upload"){
                window.location = response;
            }
            alert.text("Your account is authenticated!");
            $(alert).removeClass("alert-danger");
            $(alert).addClass("alert-success");
            alert.show();
        },
        error: function(){
            alert.text("The key inserted does not match, please re enter the key!");
            alert.show();
        },
    });
    return false;
});