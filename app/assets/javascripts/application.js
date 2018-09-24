// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


// function onload() {
//     loadButtonMove();
// }
// var HEROKUROOT = "https://protected-taiga-81728.herokuapp.com";
var HEROKUROOT = "";

function checkboxes_set_all(status) {
    var items = document.getElementsByClassName(status);
    for (let i = 0; i < items.length; i++) {
        if (items[i].checked != true) {
            items[i].checked = true;
        } else {
            items[i].checked = false;
        }
    }
}

function dropDown(id) {
    var x = document.getElementById("dropList" + id);
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
    } else {
        x.className = x.className.replace(" w3-show", "");
    }
}

function newTask() {
    var notice = document.getElementById('notice');
    notice.innerHTML = "Wait";
    var w = setInterval(() => {
        notice.innerHTML = notice.innerHTML + ".";
    }, 250);
    var z = document.getElementById("newTask");
    if (z.innerHTML == "") {
        console.log('im work');
        var myInit = {
            method: 'GET',
            credentials: 'include'
        };
        fetch(HEROKUROOT + '/tasks/new', myInit)
            .then(function (address) {
                return address.text();
            })
            .then(function (body) {
                z.innerHTML = body;
                clearInterval(w);
                notice.innerHTML = "";
            });
    } else {
        z.innerHTML = "";
        clearInterval(w);
        notice.innerHTML = "";
    }
}

function showValue(value) {
    var output = document.getElementById("showValue");
    output.innerHTML = value;
    output.style.backgroundColor = getColor(value);
    console.log("Hello, mr. " + getColor(value));
}

function getColor(id) {
    switch (+id) {
        case 1:
            return "Lightgreen";
        case 2:
            return "Green";
        case 3:
            return "Yellow";
        case 4:
            return "Orange";
        case 5:
            return "Orangered";
        default:
            return "Green";
    }
}

function destroySelected(status) {
    var path = HEROKUROOT + "/tasks/delete_selected/";
    var myInit = {
        method: 'DELETE',
        credentials: 'include'
    };
    var items = document.getElementsByClassName(status);
    for (let i = 0; i < items.length; i++) {
        if (items[i].checked == true) {
            path += items[i].id + "%";
        }
    }
    var notice = document.getElementById('notice');
    notice.innerHTML = "Wait";
    var w = setInterval(() => {
        notice.innerHTML = notice.innerHTML + ".";
    }, 250);
    fetch(path, myInit)
        .then(() => window.location = "/");
}

window.onload = function() {
    var buttonMove = document.getElementById("kittie");
    buttonMove.onmousedown = function (a) {
        function b(a) {
            buttonMove.style.top = a.pageY - c + "px";
            buttonMove.style.left = a.pageX - d + "px";
        }

        var c = a.pageY - buttonMove.getBoundingClientRect().top + pageYOffset,
            d = a.pageX - buttonMove.getBoundingClientRect().left + pageXOffset;
        buttonMove.style.position = "absolute";
        buttonMove.style.position = "fixed";
        b(a);
        document.onmousemove = function (a) {
            b(a);
        };
        window.onmouseup = function () {
            document.onmousemove = null;
            buttonMove.onmouseup = null;
        }
    };
    buttonMove.ondragstart = function () {
        return !1;
    };
};
