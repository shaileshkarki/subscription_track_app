var login_form = document.forms["login"]

var validateLoginForm = function () {
    var email = login_form["email"].value;
    if(!emailIsValid(email)) {
        alert("Email is invalid. Try again!");
        return false
    }
}

login_form.addEventListener('submit',validateLoginForm);