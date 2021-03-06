# Generated by CoffeeScript 1.6.2
deleteEvent = undefined
saveEvent = undefined
selectedAllDay = undefined
selectedEnd = undefined
selectedEvent = undefined
selectedStart = undefined
selectedEvent = null
selectedStart = null
selectedEnd = null
selectedAllDay = null
`
function cloneEvent(obj) {
  var copy = {};
  var fields = ['title', 'start', 'end', 'allDay', 'location', 'phone', 'detail', 'status'];
  var field;
  for (var ind in fields) {
    field = fields[ind];
    if (field in obj) {
      copy[field] = obj[field];
    }
  }
  return copy;
}
`

window.saveEvent = ->
  detail = undefined
  location = undefined
  phone = undefined
  title = undefined
  title = $("#title").val()
  location = $("#location").val()
  phone = $("#phone").val()
  detail = $("#detail").val()

  # new event
  if selectedEvent is null
    selectedEvent = {}
    selectedEvent.title = title
    selectedEvent.start = selectedStart
    selectedEvent.end = selectedEnd
    selectedEvent.allDay = selectedAllDay
    selectedEvent.location = location
    selectedEvent.phone = phone
    selectedEvent.detail = detail
    selectedEvent.status = 'new'
    $("#calendar").fullCalendar "addEventSource", [selectedEvent]
    
    console.log "event added localllly"
    sendToServer('new', cloneEvent(selectedEvent))

  # existing event
  else
    selectedEvent.title = title
    selectedEvent.location = location
    selectedEvent.phone = phone
    selectedEvent.detail = detail
    selectedEvent.status = 'edit'
    $("#calendar").fullCalendar "updateEvent", selectedEvent
    sendToServer('edit', cloneEvent(selectedEvent))
    $(".closeBtn").click()
  false


#    return this.preventDefault()
#    return false;
deleteEvent = ->
  $("#calendar").fullCalendar "removeEvents", selectedEvent._id
  
  #sync db
  sendToServer('delete', selectedEent)

  $(".closeBtn").click()
  false

sendToServer = (action, data) ->
  console.log 'foo'
  $.ajax
    data: data
    type: $("#submit_event").attr("method") # GET or POST
    url: "/forms/visitor/1/event" # the file to call
    success: (response) -> false
  return false
      # console.log "post was a success"



$(document).ready ->
  $("#external-events div.external-event").each ->
    eventObject = undefined
    eventObject = title: $.trim($(this).text())
    $(this).data "eventObject", eventObject
    $(this).draggable
      zIndex: 999
      revert: true
      revertDuration: 0


  $("#calendar").fullCalendar
    header:
      left: "prev,next today"
      center: "title"
      right: "month,agendaWeek,agendaDay"

    selectable: true
    editable: true
    select: (start, end, allDay) ->
      $(".modalLink").click()
      selectedEvent = null
      selectedStart = start
      selectedEnd = end
      selectedAllDay = allDay

    eventClick: (calEvent, jsEvent, view) ->
      selectedEvent = calEvent
      $("#title").val calEvent.title
      $("#location").val calEvent.location
      $("#phone").val calEvent.phone
      $("#detail").val calEvent.detail
      $(".modalLink").click()



# return $("#calendar").fullCalendar('addEventSource', "{{event_data}}");
$(".modalLink").modal
  trigger: ".modalLink"
  olay: "div.overlay"
  modals: "div.modal"
  animationEffect: "slidedown"
  animationSpeed: 400
  moveModalSpeed: "slow"
  background: "00c2ff"
  opacity: 0.8
  openOnLoad: false
  docClose: true
  closeByEscape: true
  moveOnScroll: true
  resizeWindow: true
  video: "http://player.vimeo.com/video/9641036?color=eb5a3d"
  close: ".closeBtn"

