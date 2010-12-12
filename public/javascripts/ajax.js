// AJAX FUNCTIONS

jQuery.ajaxSetup({ 'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")} })

function _ajax_request(url, data, callback, type, method) {
    if (jQuery.isFunction(data)) {
        callback = data;
        data = {};
    }
    return jQuery.ajax({
        type: method,
        url: url,
        data: data,
        success: callback,
        error: function(result) { $('#notices').html('A javascript error occurred.') },
        dataType: type
        });
}

jQuery.extend({
    put: function(url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'PUT');
    },
    delete_: function(url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'DELETE');
    }
});

jQuery.fn.submit_with_ajax = function() {
  this.unbind('submit', false);
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

//Send data via get if <acronym title="JavaScript">JS</acronym> enabled
jQuery.fn.get_with_ajax = function() {
  this.unbind('click', false);
  this.click(function() {
    $.get($(this).attr("href"), $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

//Send data via Post if <acronym title="JavaScript">JS</acronym> enabled
jQuery.fn.post_with_ajax = function() {
  this.unbind('click', false);
  this.click(function() {
    $.post($(this).attr("href"), $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

jQuery.fn.put_with_ajax = function() {
  this.unbind('click', false);
  this.click(function() {
    $.put($(this).attr("href"), $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

jQuery.fn.delete_with_ajax = function() {
  this.removeAttr('onclick');
  this.unbind('click', false);
  this.click(function() {
    input_box=confirm("You are about to delete a record. This action can not be reversed. Click 'OK' to continue or 'Cancel' to abort.");
    if (input_box==true){ 
      // OK response
      $.delete_($(this).attr("href"), $(this).serialize(), null, "script");
    }
    // if Cancel do nothing
    return false;
  })
  return this;
};

//This will "ajaxify" the links
function ajax_links_and_forms(){
    $('.ajax_form').submit_with_ajax();
    //$('a.get').get_with_ajax();
    // $('a.post').post_with_ajax();
    // $('a.put').put_with_ajax();
    // $('a.delete').delete_with_ajax();
    // 
    // $('tr.get').get_with_ajax();
    $('td.get').get_with_ajax();
    // $('td.delete').delete_with_ajax();
}

function manual_get_with_ajax(url) {
  $.get($(this).attr(url), null, null, "script");
  return false;
}
