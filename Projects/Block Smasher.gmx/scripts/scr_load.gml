ini_open("block_smasher.ini");
global.money = ini_read_real("Data","Money",0);
global.exper = ini_read_real("Data","Exp",0);
global.level = ini_read_real("Data","Level",0);
global.haltbarkeit = ini_read_real("Data","Durability",0);
global.hits = ini_read_real("Data","Hits",0);
global.gift = ini_read_real("Data","Gift",0);
ini_close();
