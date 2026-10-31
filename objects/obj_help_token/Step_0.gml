// Fade in
alpha = min(alpha + 0.05, 1);

// Lifetime
lifetime--;
if (lifetime <= 0) instance_destroy();

// Bob up and down visually
bob_timer++;
image_yscale = 1 + sin(bob_timer / 10) * 0.1;