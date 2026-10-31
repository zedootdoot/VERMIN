// obj_computer Create Event
ui_open = false;
interact_distance = 12; // distance required to open UI

// Menu items
menu_items = ["Job_001", "EXIT"];
menu_selection = 0;

// Job descriptions (aligned with menu_items)
job_descriptions = [
    "Job_001: Location: Home Attic\n\nAttic is infested with rats.\nExterminate them all.",
    "" // placeholder for EXIT or future jobs
];

// Typing effect
typed_text = "";           // what’s currently displayed
typing_index = 0;          // position in the string
typing_speed = 1;          // lower = faster typing
typing_timer = 0;          // frame counter

global.options_allowed = false;