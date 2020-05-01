

// var login_form = document.forms["login"]

var emailIsValid = function (email) {
    return /\S+@\S+\.\S+/.test(email)
}  
// var validateSignupForm = function () {
//     var email = signup["email"].value;
//     var password = signup["password"].value;
//     var re_password = signup["re_password"].value;
//     if(!emailIsValid(email)) {
//         alert("Email is invalid. Try again!");
//         return false
//     }
//     if (password != re_password) {
//         alert("Password and Re-password did not match. Try again!");
//         return false;
//     }
//   }
// var validateNewForm = function () {
//     var  start_date = Date.parse(new_form["start_date"])
//     var cancel_date = Date.parse(new_form["cancel_date"])
//     if (cancel_date < start_date) {
//         alert("Cancel date cannot be earlier than start date. Try again!");
//         return false 
//     }
// }
//   var validateLoginForm = function () {
//     var email = login_form["email"].value;
//     if(!emailIsValid(email)) {
//         alert("Email is invalid. Try again!");
//         return false
//     }
// }
// var validateEditForm = function () {
//     var  start_date = Date.parse(edit_form["start_date"])
//     var cancel_date = Date.parse(edit_form["cancel_date"])
//     if (cancel_date < start_date) {
//         alert("Cancel date cannot be earlier than start date. Try again!");
//         return false 
//     }
// }
// // var validateSignupForm = function () {
// //     var email = signup["email"].value;
// //     var password = signup["password"].value;
// //     var re_password = signup["re_password"].value;
// //     if(!emailIsValid(email)) {
// //         alert("Email is invalid. Try again!");
// //         return false
// //     }
// //     if (password != re_password) {
// //         alert("Password and Re-password did not match. Try again!");
// //         return false;
// //     }
// //   }

// // signup_form.addEventListener('submit',validateSignupForm);
// login_form.addEventListener('submit',validateLoginForm);
// // edit_form.addEventListener('submit',validateEditForm);

