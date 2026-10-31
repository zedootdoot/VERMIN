// Get user and system names
player_name = environment_get_variable("USERNAME");
if (player_name == "") player_name = "Player";
system_name = environment_get_variable("COMPUTERNAME");
if (system_name == "") system_name = "SYSTEM";

if (global.current_music != noone) audio_stop_sound(global.current_music);
global.current_music = audio_play_sound(vermin14, 1, false);
global.options_allowed = false;

// Full credits text — blank lines act as card separators
//credits_text = "Haha get pranked \nthe game isnt quite finished yet\n\n\nEND OF DEMO\n\n\nCREATED BY:\nAIDIN A\n\nSTORY BY:\nAIDIN A\n\nPROGRAMMING:\nAIDIN A\n\nDEBUGGING:\nAIDIN A\n\nART:\nAIDIN A\n\nMUSIC:\nARMAAN A \n\nPLAYTESTERS: \nAIDIN A \nARMAAN A\nGARRY Y \n\nthe reason the spray doesn't \nlook like piss: \nJOSHUA Y\n\nINSPIRED BY:\nthat one fruit fly\nthat fell\nINTO MY FRICKING CUP OF WATER\n\n\n\nDEDICATED TO: \nColleg (pls accept me i beg) \n\nMade with GameMaker Studio 2 \n\n\n\nSPECIAL THANKS, \nYOU, " + player_name + ". \nSYSTEM: " + system_name + "\n\n\n\n\nto be continued...\n\n2026\n\n(also you cannot change the volume\nbecause i deem it so.)\n\n\n\n\n[VERMIN] DEMO";
credits_text = "THE END OF\n\n\n[VERMIN]\n\n\nCREATED BY:\n\nAIDIN A\n\n\nSTORY BY:\n\nAIDIN A\n\n\nPROGRAMMING:\n\nAIDIN A\n\n\nDEBUGGING:\n\nAIDIN A\n\n\nART & SPRITES:\n\nAIDIN A\n\n\nANIMATION:\n\nAIDIN A\n\n\nMUSIC:\n\nARMAAN A\n\nAIDIN A\n\n\nSOUND EFFECTS:\n\nARMAAN A\n\n\nLEVEL DESIGN:\n\nAIDIN A\n\n\nGAMEPLAY DESIGN:\n\nAIDIN A\n\n\nUI DESIGN:\n\nAIDIN A\n\n\nPLAYTESTERS:\n\nAIDIN A\n\nARMAAN A\n\nGARRY Y\n\nJOSHUA Y\n\nRYUNOSUKE M\n\n\nthe reason the spray doesn't\n\nlook like piss:\n\nJOSHUA Y\n\n\nINSPIRED TO MAKE A GAME BY:\n\nUNDERTALE\n\nONESHOT\n\nOMORI\n\n\nDEDICATED TO:\n\nColleg\n\n(pls accept me i beg)\n\n\nMade with GameMaker Studio 2026\n\n\nSPECIAL THANKS,\n\nYOU, " + player_name + ".\n\nSYSTEM: " + system_name + "\n\n\nEXTRA CREDITS:\n\nGameMaker RPG Tutorial\n\n\nthe subconscious knowledge that\n\none day this game\n\nwill actually be finished\n\n\nthat one fruit fly that\n\nfell into my water\n\ninspiring this game\n\n\nTO BE RELEASED\n\n\n2026\n\n\nThanks for playing\n\n\n[VERMIN]";

// Use ||| as a safe internal separator for card breaks
var card_split_text = string_replace_all(credits_text, "\n\n\n", "|||");

// Split into cards first
var raw_cards = string_split(card_split_text, "|||");
cards = [];

for (var c = 0; c < array_length(raw_cards); c++) {
    // Split each card's content into lines
    var card_lines = string_split(raw_cards[c], "\n");
    
    // Strip leading/trailing blank lines from each card
    var first = 0;
    var last = array_length(card_lines) - 1;
    while (first <= last && card_lines[first] == "") first++;
    while (last >= first && card_lines[last] == "") last--;
    
    var clean_card = [];
    for (var i = first; i <= last; i++) {
        array_push(clean_card, card_lines[i]);
    }
    
    if (array_length(clean_card) > 0) array_push(cards, clean_card);
}

// --- Playback state ---
card_index   = 0;
card_alpha   = 0;
card_state   = "fade_in";   // fade_in | hold | fade_out
state_timer  = 0;

FADE_SPEED   = 0.03;   // alpha per step
HOLD_FRAMES  = 120;    // how long each card stays fully visible (~2s at 60fps)
PAUSE_FRAMES = 100; 

// --- Secret code ---
secret_code    = [vk_left, vk_right, vk_left, vk_up, vk_up];
secret_input   = [];
secret_cooldown = 0;
secret_timeout  = 0;