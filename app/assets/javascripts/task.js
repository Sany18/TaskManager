jQuery(document).ready(function () {
  var HEROKUROOT = "";

  $(".checkboxes_set_all_0").click(() => {
    change_checkboxes(".checkbox_belongs_0")
  });
  $(".checkboxes_set_all_1").click(() => {
    change_checkboxes(".checkbox_belongs_1")
  });

  function change_checkboxes(checkboxes_class) {
    var items = $(checkboxes_class);
    for (let i = 0; i < items.length; i++) {
      if (items[i].checked != true) {
        items[i].checked = true;
      } else {
        items[i].checked = false;
      }
    }
  }

  $(".drop_down").click((x = $(this)) => {
    curent_list = x.currentTarget.className.replace("w3-dropdown-click drop_down ", "");
    var button = $("#" + curent_list);
    if (button.hasClass("w3-show") === false) {
      button.addClass("w3-show");
    } else {
      button.removeClass("w3-show");
    }
  });

  //Для динамически созданных элементов
  $(document).on('click', '.close_new_task', () => {
    console.log('ble');
    $("#new_task").css("display", "none").html("");
  });

  $(".new_task_button").click(() => {
    var notice = $('#notice');
    var new_task_div = $("#new_task");

    if (new_task_div.css("display") === "none") {
      notice.html("Wait");
      var w = setInterval(() => {
        notice.html(notice.text() + ".")
      }, 250);

      $.get(HEROKUROOT + '/tasks/new')
        .done((data) => {
          new_task_div.html(data).css("display", "block");
        })
        .fail(() => {
          clearInterval(w);
          notice.html("We have some problem");
        })
        .always(() => {
          clearInterval(w);
          notice.html("");
        });
    } else {
      new_task_div.css("display", "none").html("");
      notice.html("");
    }
  });

  $(".slider").on("input change", () => {
    let slider = $(".slider");
    let value = slider.val();
    let output = $("#show_value");
    output.html(value);
    slider.css("background-color", getColor(value));
    console.log("Hello, mr. " + getColor(value));
  });

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

  $(".destroy_selected_0").click(() => {
    destroy_selected(".checkbox_belongs_0")
  });
  $(".destroy_selected_1").click(() => {
    destroy_selected(".checkbox_belongs_1")
  });

  function destroy_selected(checkboxes_class) {
    var path = HEROKUROOT + "/task/delete_selected/";
    var items = $(checkboxes_class);
    for (let i = 0; i < items.length; i++) {
      if (items[i].checked == true) {
        path += items[i].id + "%";
      }
    }
    var notice = $('#notice');
    notice.innerHTML = "Wait";
    var w = setInterval(() => {
      notice.innerHTML = notice.innerHTML + ".";
    }, 250);

    $.ajax({
      url: path,
      type: 'DELETE',
      success: function (result) {
        window.location = "/";
      }
    })
  }

  (() => {
    var buttonMove = document.getElementById("kittien");
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
  })();
});