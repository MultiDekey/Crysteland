if global.money <= 10
{
    global.money -= 1;
}
if global.money >= 11
if global.money <= 50
{
    global.money -= 3;
}
if global.money >= 51
if global.money <= 100
{
    global.money -= 5;
}
if global.money >= 101
if global.money < 200
{
    global.money -= 10;
}
if global.money >= 201
if global.money < 300
{
    global.money -= 20;
}
if global.money >= 301
if global.money < 400
{
    global.money -= 30;
}
if global.money >= 401
if global.money < 500
{
    global.money -= 40;
}
if global.money >= 501
{
    global.money -= 50;
}
scr_save();
