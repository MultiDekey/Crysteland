// draw_tooltip (tip, outline color, backgroud color, x, y);
// Achtung: Dieses Script setzt den halign auf fa_left und den valign auf fa_middle!
var tip, wid, hei, col, bac, psx, psy, tmc;
tip = argument0; // Der anzuzeigende Tooltip
col = argument1; // Die Farbe der Umrandung des Tooltips
bac = argument2; // Die Hintergrundfarbe des Tooltips
psx = argument3; // Die x Position, an der der Tooltip angezeigt werden soll
psy = argument4; // Die y Position, an der der Tooltip angezeigt werden soll

tmc = draw_get_color();
wid = 4 + string_width(tip) + 4; 
hei = 2 + string_height(tip) + 2;

draw_set_color(bac); 
draw_rectangle(psx, psy - hei / 2, psx + wid, psy + hei / 2, false); // Hier...

draw_set_color(col);
draw_rectangle(psx, psy - hei / 2, psx + wid, psy + hei / 2, true); // ...und hier wird das Tooltip Rechteck gezeichnet...

draw_set_color(tmc);
draw_set_halign(fa_left); draw_set_valign(fa_middle);
draw_text(psx + 4, psy, tip); // ...und hier der Tooltip-Text


