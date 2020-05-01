var edit_form = document.forms["edit"]

var validateEditForm = function () {
    var  start_date = Date.parse(edit_form["start_date"])
    var cancel_date = Date.parse(edit_form["cancel_date"])
    if (cancel_date < start_date) {
        alert("Cancel date cannot be earlier than start date. Try again!");
        return false 
    }
}

edit_form.addEventListener('submit',validateEditForm);