ini_open("cavern.ini");
global.money = ini_read_real("Data","Money",0);
global.tresor_money = ini_read_real("Data","Safemoney",0);
global.bombs = ini_read_real("Data","Bombs",0);
global.ammo = ini_read_real("Data","Ammo",0);
global.gun = ini_read_real("Data","Gun",0);
global.sword = ini_read_real("Data","Sword",0);

global.show_hud = ini_read_real("Options","Show_hud",0);
global.show_fps = ini_read_real("Options","Show_fps",0);
ini_close();
