//scr_player_move(geschwindigkeit, richtung)
//Speziell auf das Playerobjekt angepasst, kann man aber sicher auch fuer andere Objekte verwenden, NPCs z.B.

this_movingspeedX = argument0;
this_movingspeedY = argument1;
this_directionX = argument2;
this_directionY = argument3;

if (place_free(x + this_directionX * this_movingspeedX, y + this_directionY * this_movingspeedY)){ //normale Bewegung in Blickrichtung, Distanz abhaengig vom movingspeed
    x += this_movingspeedX * this_directionX;
    y += this_movingspeedY * this_directionY;
    
}else if (place_free(x + this_directionX * this_movingspeedX, y - this_movingspeedX)){ //Bewegung eine Schraege nach oben, s.o.
    x += this_directionX * this_movingspeedX;
    y -= this_movingspeedY;
    
}else if (place_free(x + this_directionX, y)){ //schliesst eventuelle abstaende zwischen playerobjekt und einer Wand, kann man auch weglassen
    x += this_directionX;

}




/*
langsame Aufwaertsbewegung eine Schraege hinauf
den Code muss man mit dem mittleren 'else if' von oben vertauschen
vll. interessiert das jemanden

else if (place_free(x + global.dir, y - 1)){ //Bewegung eine Schraege nach oben
    x += global.dir;
    y -= 1;
    
}

*/
