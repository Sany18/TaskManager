jQuery(document).ready(function () {
  function changeCheckboxes(checkboxes_class) {
    var items = $(checkboxes_class);
    for (let i = 0; i < items.length; i++) {
      if (!items[i].checked) {
        items[i].checked = true;
      } else {
        items[i].checked = false;
      }
    }
  }

  $(".drop_down").click((current_task_btn = $(this)) => {
    var dropdown_current_task_width_id = current_task_btn.currentTarget.className.replace("w3-dropdown-click drop_down ", "");
    $("#" + dropdown_current_task_width_id).toggleClass("w3-show");
  });

  function modalWindow_NewTask() {
    var notice = $('#notice');
    var new_task_div = $("#new_task_div");

    if (!new_task_div.is(":visible")) {
      notice.html("Wait");
      var w = setInterval(() => {
        notice.html(notice.text() + ".")
      }, 250);

      $.get('/tasks/new')
        .done((data) => {
          new_task_div.html(data).show(100);
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
      new_task_div.hide(100).html("");
      notice.html("");
    }
  }

  $(document).on("input change", ".slider", () => {
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

  $.fn.deleteTask = (id) => {
    var path = "/task/delete_selected/" + id;

    $.ajax({
      url: path,
      type: 'DELETE',
      success: function () {
        $(".drop_list" + id).remove();
        $('#notice').html("Task deleted");
      },
      error: (xhr, ajaxOptions, thrownError) => {
        $('#notice').html("Delete failed: " + thrownError);
      }
    })
  };

  function destroySelected(checkboxes_class) {
    var path = "/task/delete_selected/";
    var items = $(checkboxes_class);
    var notice = $('#notice');

    for (let i = 0; i < items.length; i++) {
      if (items[i].checked) {
        path += items[i].id + "%";
      }
    }

    notice.html("Wait");
    var w = setInterval(() => {
      notice.html(notice.text() + ".");
    }, 250);

    $.ajax({
      url: path,
      type: 'DELETE',
      success: function () {
        for (let i = 0; i < items.length; i++) {
          if (items[i].checked) {
            let id = items[i].id;
            $(".drop_list" + id).remove();
            clearInterval(w);
          }
        }
        $('#notice').html("Selected tasks deleted.");
      },
      error: (xhr, ajaxOptions, thrownError) => {
        clearInterval(w);
        $('#notice').html("Delete failed: " + thrownError);
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

  $("#new_task_div").hide();

  $("#new_task_button").click(() => {
    modalWindow_NewTask();
  });

  $("#destroy_selected_not_completed_btn").click(() => {
    destroySelected(".checkbox_belongs_not_completed")
  });
  $("#destroy_selected_completed_btn").click(() => {
    destroySelected(".checkbox_belongs_completed")
  });

  $("#checkbox_set_all_not_completed").click(() => {
    changeCheckboxes(".checkbox_belongs_not_completed")
  });
  $("#checkbox_set_all_completed").click(() => {
    changeCheckboxes(".checkbox_belongs_completed")
  });

  //Для динамически созданных элементов
  $(document).on('click', '.close_new_task_btn', () => {
    $("#new_task_div").css("display", "none").html("");
  });
});