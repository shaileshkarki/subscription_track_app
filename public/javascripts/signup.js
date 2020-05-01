var signup_form = document.forms["signup"]
var validateSignupForm = function () {
    var email = signup["email"].value;
    var password = signup["password"].value;
    var re_password = signup["re_password"].value;
    if(!emailIsValid(email)) {
        alert("Email is invalid. Try again!");
        return false
    }
    if (password != re_password) {
        alert("Password and Re-password did not match. Try again!");
        return false;
    }
}

signup_form.addEventListener('submit',validateSignupForm);