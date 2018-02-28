// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";

var block_id;
var edit_button;


function save_block(ev) {
  let btn = $(ev.target);
  let text = JSON.stringify({
    timeblock: {
    	start: new Date($('#starttime').val()).toISOString(),
    	stop: new Date($('#stoptime').val()).toISOString(),
    	block_id: btn.data('task-id')
      },
  });

  $.ajax(timeblock_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { block_id = resp.data.id; },
  });
  window.location.reload(true);
}

function edit_block(ev) {
  let btn = $(ev.target);
  edit_button = btn;
  $('.hidden').show();
}

function save_edit_block(ev) {
  let btn = $(ev.target);
  let text = JSON.stringify({
    timeblock: {
    	start: new Date($('#editstarttime').val()).toISOString(),
    	stop: new Date($('#editstoptime').val()).toISOString(),
      },
  });
  block_id = edit_button.data('edit')
  $.ajax(timeblock_path + "/" + block_id, {
    method: "patch",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { console.log("Saved Successfully") },
  });
  $('.hidden').hide();
  window.location.reload(true)
}

function delete_block(ev) {
  let btn = $(ev.target);
  let text = JSON.stringify({
    timeblock: {
    	id: btn.data('delete')
      },
  });
  block_id = btn.data('delete')
  $.ajax(timeblock_path + "/" + block_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { console.log("Deleted Successfully") },
  });
  window.location.reload(true);
}

function start(ev) {
  let btn = $(ev.target);
  let text = JSON.stringify({
    timeblock: {
        start: btn.data('start'),
    	stop: btn.data('start'),
    	block_id: btn.data('task-id')
      },
  });

  $.ajax(timeblock_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { block_id = resp.data.id; },
  });
}

function stop(ev) {
  let btn = $(ev.target);
  let text = JSON.stringify({
    timeblock: {
        start: btn.data('start'),
    	stop: btn.data('stop'),
    	block_id: btn.data('task-id')
      },
  });

  $.ajax(timeblock_path + "/" + block_id, {
    method: "patch",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { console.log("You stopped working") },
  });
  window.location.reload(true);
}

function init_timeblock() {
  if (!$('.start-button')) {
    return;
  }

  $(".start-button").click(start);
  $(".stop-button").click(stop);
  $(".edit-button").click(edit_block);
  $(".delete-button").click(delete_block);
  $(".save-button").click(save_block);
  $(".save-edit-button").click(save_edit_block);

}

$(init_timeblock);
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
