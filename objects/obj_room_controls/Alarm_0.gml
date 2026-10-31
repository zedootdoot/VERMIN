// Trigger the fade-out using obj_fade
with (obj_fade) {
    fading_out = true; // variable already defined in obj_fade Create Event
    next_room = other.next_room; // take the room from the controller
}