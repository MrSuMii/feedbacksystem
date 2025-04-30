var a= fun.addEventListener("submit", function (event) {
    event.preventDefault(); // Prevent form submission

    // Validate form fields (you can add more validation as needed)
    var firstName = document.getElementById("first-name").value;
    var lastName = document.getElementById("last-name").value;
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;
    var email = document.getElementById("email").value;
    var phone = document.getElementById("phone").value;
    var gender = document.getElementById("gender").value;
    var passport = document.getElementById("passport").value;

    if (firstName === '' || lastName === '' || username === '' || password === '' || email === '' || phone === '' || gender === '' || passport === '') {
        document.getElementById("error").textContent = "Please fill out all fields.";
        return;
    }

    window.location.href = "login.html"; // Replace with your actual login page URL
});

function myFunction() {
    var x = document.getElementById("password");
    if (x.type === "password") {
        x.type = "text";
    } else {
        x.type = "password";
    }
}

function validatePassword() {
    var password = document.getElementById("password").value;
    var length = document.getElementById("length");
    var number = document.getElementById("number");
    var lowercase = document.getElementById("lowercase");
    var uppercase = document.getElementById("uppercase");
    var special = document.getElementById("special");
    var isValid = true;

    if (password.length >= 8) {
        length.classList.remove("invalid");
        length.classList.add("valid");
    } else {
        length.classList.remove("valid");
        length.classList.add("invalid");
        isValid = false;
    }

    if (/[0-9]/.test(password)) {
        number.classList.remove("invalid");
        number.classList.add("valid");
    } else {
        number.classList.remove("valid");
        number.classList.add("invalid");
        isValid = false;
    }

    if (/[a-z]/.test(password)) {
        lowercase.classList.remove("invalid");
        lowercase.classList.add("valid");
    } else {
        lowercase.classList.remove("valid");
        lowercase.classList.add("invalid");
        isValid = false;
    }

    if (/[A-Z]/.test(password)) {
        uppercase.classList.remove("invalid");
        uppercase.classList.add("valid");
    } else {
        uppercase.classList.remove("valid");
        uppercase.classList.add("invalid");
        isValid = false;
    }

    if (/[^a-zA-Z0-9]/.test(password)) {
        special.classList.remove("invalid");
        special.classList.add("valid");
    } else {
        special.classList.remove("valid");
        special.classList.add("invalid");
        isValid = false;
    }

    if (isValid) {
        document.getElementById("password").classList.remove("invalid");
        document.getElementById("password").classList.add("valid");
    } else {
        document.getElementById("password").classList.remove("valid");
        document.getElementById("password").classList.add("invalid");
    }
}

function showValidation() {
    document.getElementById("message").style.display = "block";
}

function hideValidation() {
    document.getElementById("message").style.display = "none";
}