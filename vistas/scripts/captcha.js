$('form').submit(function (event) {
    event.preventDefault();
    $.ajax({
        url: 'captcha.php',
        type: 'post',
        data: $('form').serialize(),
        dataType: 'json',
        success: function (response) {
            var error = response.error;
            var success = response.success;
            if (error != "") {
                $('#alert_message').html(error);

            } else {
                $('#alert_message').html(success);
                log();

            }
        },
        error: function (jqXhr, json, errorThrown) {
            var error = jqXhr.responseText;
            $('#alert_message').html(error);
        }
    });
});

