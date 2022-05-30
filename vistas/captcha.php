<?php
function is_entered_data_valid() {

    if($_POST['logina'] != "" && $_POST['clavea'] != "") {
        return true;
    } else {
        return false;
    }
}

if(is_entered_data_valid()) {

    if(isset($_POST['h-captcha-response']) && !empty($_POST['h-captcha-response'])){
        $secret = "0xE2De3e4B7bFeEBcb5b6AcDF567097BF66BEa9458"; // Replace it with your generated secret key
        $remote_address = $_SERVER['REMOTE_ADDR'];
        $verify_url = "https://hcaptcha.com/siteverify?secret=".$secret."&response=".$_POST['h-captcha-response']."&remoteip=".$remote_address;
        // This is hcaptcha url
        $response = file_get_contents($verify_url); # Get token from post data with key 'h-captcha-response' and Make a POST request with data payload to hCaptcha API endpoint
        $responseData = json_decode($response);
        $success_msg="";
        $err_msg="";
        if($responseData->success){
            $success_msg = "Captcha realizado con exito, presione nuevamente";
        }else{
            $err_msg =  "Algo salió mal al hacer la validación, realizé nuevamente.";
        }

    }else{
        $err_msg =  "Por favor complete el captcha";
    }

} else {
    // Server side validation failed
    $error_output = "Usuario o contraseña incorrectos";
}

// Get the response and pass it into your ajax as a response.
$return_msg = array(
    'error'     =>  $err_msg,
    'success'   =>  $success_msg
);
echo json_encode($return_msg);

?>