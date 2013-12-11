if (!file_exists("Prelode_Screen " + string(value) + ".png"))
{
screen_save("Prelode_Screen " + string(value) + ".png");
value += 1;
}
else
{
find_value = 1;
}

if (find_value == 1)
{
value += 1;
    if (!file_exists("Prelode_Screen " + string(value) + ".png"))
    {
    screen_save("Prelode_Screen " + string(value) + ".png");
    find_value = 0;
    }
}
