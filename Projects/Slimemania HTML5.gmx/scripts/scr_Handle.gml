{
 if (global.spin_enabled = true){
  
//  sound_play(Insert_Coin);
  global.money -= global.spin_cost
  image_single = -1

  //disable spin button
  global.spin_enabled = false

  //start reel animation
 obj_reel1.image_single = -1
 obj_reel2.image_single = -1
 obj_reel3.image_single = -1

  //set alarm0 on controller
  with(obj_slot_controller){
   alarm[0] = room_speed*global.spin_duration
   alarm[1] = room_speed*global.spin_duration + 0.5
  }
 }
}
