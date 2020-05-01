var new_form = document.forms["new"]
var validateNewForm = function () {
    var  start_date = Date.parse(new_form["start_date"])
    var cancel_date = Date.parse(new_form["cancel_date"])
    if (cancel_date < start_date) {
        alert("Cancel date cannot be earlier than start date. Try again!");
        return false 
    }
}

new_form.addEventListener('submit',validateNewForm);