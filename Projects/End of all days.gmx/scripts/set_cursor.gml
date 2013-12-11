//set_cursor(spr,show)
// argument0 - your own cursor image : sprite or noone
// argument1 - show the default cursor : true or false
cursor_sprite=argument0;
if !argument1
{
    window_set_cursor(cr_none);
}
else
{
    window_set_cursor(cr_default);
}
