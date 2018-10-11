jQuery(document).ready(function () {
  function showNewTaskForm() {
    var notice = $('#notice');
    var newTaskDiv = $("#new_task_div");

    if (!newTaskDiv.is(":visible")) {
      notice.html("Wait");
      var w = setInterval(() => {
        notice.html(notice.text() + ".")
      }, 250);

      $.get('/tasks/new')
        .done((data) => {
          newTaskDiv.html(data).show(100);
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
      newTaskDiv.hide(100).html("");
      notice.html("");
    }
  }

  function showPriorityInColor() {
    let slider = $(".slider");
    let value = slider.val();
    $("#show_value").html(value);
    slider.css("background-color", getColor(value));
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

  function deleteTask(currentTaskBtn) {
    let taskId = currentTaskBtn.currentTarget.id.replace('delete_task_id:', '');
    let path = "/task/delete_selected/" + taskId;

    $.ajax({
      url: path,
      type: 'DELETE',
      success: function () {
        $(".dropdown" + taskId).remove();
        $('#notice').html("Task deleted");
      },
      error: (xhr, ajaxOptions, thrownError) => {
        $('#notice').html("Delete failed: " + thrownError);
      }
    })
  }

  function destroySelected(checkboxes_class) {
    var path = "/task/delete_selected/";
    var checkedTask = $(checkboxes_class + ":checked");
    var notice = $('#notice');

    for (let i = 0; i < checkedTask.length; i++) {
      path += checkedTask[i].id + "&";
    }

    notice.html("Wait");
    var w = setInterval(() => {
      notice.html(notice.text() + ".");
    }, 250);

    $.ajax({
      url: path,
      type: 'DELETE',
      success: function () {
        for (let i = 0; i < checkedTask.length; i++) {
          let id = checkedTask[i].id;
          $(".dropdown" + id).remove();
          clearInterval(w);
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

  function showTask(dropdownTaskBtn) {
    var dropdownCurrentTaskWidthId = dropdownTaskBtn.currentTarget.className.replace("w3-dropdown-click drop_down_btn ", "");
    $("#" + dropdownCurrentTaskWidthId).toggleClass("w3-show");
  }


  $(".drop_down_btn").click((dropdownTaskBtn = $(this)) => {
    showTask(dropdownTaskBtn)
  });

  $(".delete_current_task").click((deleteTaskBtn = $(this)) => {
    deleteTask(deleteTaskBtn)
  });

  $("#new_task_div").hide();

  $("#new_task_button").click(() => {
    showNewTaskForm();
  });

  $("#destroy_selected_not_completed_btn").click(() => {
    destroySelected(".checkbox_belongs_not_completed")
  });

  $("#destroy_selected_completed_btn").click(() => {
    destroySelected(".checkbox_belongs_completed")
  });

  $("#checkbox_set_all_not_completed").click(() => {
    $(".checkbox_belongs_not_completed").prop("checked", $("#checkbox_set_all_not_completed").prop("checked"));
  });

  $("#checkbox_set_all_completed").click(() => {
    $(".checkbox_belongs_completed").prop("checked", $("#checkbox_set_all_completed").prop("checked"));
  });

//Для динамически созданных элементов
  $(document).on("input change", ".slider", () => {
    showPriorityInColor()
  });

  $(document).on('click', '.close_new_task_btn', () => {
    $("#new_task_div").hide(100).html("")
  });
});