// Generated by CoffeeScript 1.6.2
var deleteEvent, saveEvent, selectedAllDay, selectedEnd, selectedEvent, selectedStart;

selectedEvent = null;

selectedStart = null;

selectedEnd = null;

selectedAllDay = null;

saveEvent = function() {
  var detail, location, phone, title;
  title = $('#title').val();
  location = $('#location').val();
  phone = $('#phone').val();
  detail = $('#detail').val();
  if (selectedEvent !== null) {
    selectedEvent.title = title;
    selectedEvent.location = location;
    selectedEvent.phone = phone;
    selectedEvent.detail = detail;
    $('#calendar').fullCalendar('updateEvent', selectedEvent);
    //sync db

    console.log('event updated');
  } else {
    selectedEvent = {};
    selectedEvent.title = title;
    selectedEvent.start = selectedStart;
    selectedEvent.end = selectedEnd;
    selectedEvent.allDay = selectedAllDay;
    selectedEvent.location = location;
    selectedEvent.phone = phone;
    selectedEvent.detail = detail;
    $('#calendar').fullCalendar('addEventSource', [selectedEvent]);
    //sync db
    // update event id

    console.log('event added');
  }
  return $('.closeBtn').click();
};

deleteEvent = function() {
  $('#calendar').fullCalendar("removeEvents", selectedEvent._id);
  //sync db

  return $('.closeBtn').click();
};

$(document).ready(function() {
  $("#external-events div.external-event").each(function() {
    var eventObject;
    eventObject = {
      title: $.trim($(this).text())
    };
    $(this).data("eventObject", eventObject);
    return $(this).draggable({
      zIndex: 999,
      revert: true,
      revertDuration: 0
    });
  });
  return $("#calendar").fullCalendar({
    header: {
      left: "prev,next today",
      center: "title",
      right: "month,agendaWeek,agendaDay"
    },
    selectable: true,
    editable: true,
    select: function(start, end, allDay) {
      $('.modalLink').click();
      selectedEvent = null;
      selectedStart = start;
      selectedEnd = end;
      return selectedAllDay = allDay;
    },
    eventClick: function(calEvent, jsEvent, view) {
      selectedEvent = calEvent;
      $('#title').val(calEvent.title);
      $('#location').val(calEvent.location);
      $('#phone').val(calEvent.phone);
      $('#detail').val(calEvent.detail);
      $('.modalLink').click();
      // return $("#calendar").fullCalendar('addEventSource', "{{event_data}}");
    }
  });
});
$('.modalLink').modal({
  trigger: '.modalLink',
  olay: 'div.overlay',
  modals: 'div.modal',
  animationEffect: 'slidedown',
  animationSpeed: 400,
  moveModalSpeed: 'slow',
  background: '00c2ff',
  opacity: 0.8,
  openOnLoad: false,
  docClose: true,
  closeByEscape: true,
  moveOnScroll: true,
  resizeWindow: true,
  video: 'http://player.vimeo.com/video/9641036?color=eb5a3d',
  close: '.closeBtn'
});;
