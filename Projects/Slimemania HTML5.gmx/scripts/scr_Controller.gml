{
 //randomize reels
reel1rnd = floor(random(3))
reel2rnd = floor(random(3))
reel3rnd = floor(random(3))

 //stop reel
 obj_reel1.image_single = reel1rnd
 obj_reel2.image_single = reel2rnd
 obj_reel3.image_single = reel3rnd
 ini_open("game_stats.ini");
 ini_write_real("Char","Money",global.money);
 ini_close();
 sound_play(snd_clack);

 //check for winner
 if(scr_win_check()){ sound_play(snd_buy); }

}
