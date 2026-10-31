showing = false;
payment_amount = 0;
payment_text = "";
timer = 0;
display_duration = 180;

function show_payment(_amount, _skepticism) {
    payment_amount = _amount;
    payment_text = _skepticism;
    showing = true;
    timer = display_duration;
    audio_play_sound(snd_money, 1, false);
}