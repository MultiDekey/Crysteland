#define GMech_AchievementTitle
if argument0>0
{
    if global.gmech_initialized=1
    {
        return string(global.gameAch[argument0])
    }
    else
    {
        return "GMechanism not initialized!"
    }
}
else
{
    return "N/A";
}

#define GMech_Connected
if global.gmech_initialized=1 and os_is_network_connected()
{
    return 1;
}
else
{
    return 0;
}   

#define GMech_DecryptFile
var file, byte, pos, key;
file = file_bin_open( argument0, 2);
pos = 1;
while( file_bin_position( file) < file_bin_size( file)) {
    if ( pos <= string_length( argument1)) {
        pos += 1;
    } else pos = 1;
    key = ord( string_char_at( argument1, pos));
    byte = file_bin_read_byte( file);
    file_bin_seek( file, file_bin_position( file) - 1);
    byte -= key;
    if ( byte < 0) byte += 256;
    file_bin_write_byte( file, byte);
}
file_bin_close( file);

#define GMech_DisplayHighScores
gmech_tid=argument0 //Hightscore table slot id
gmech_gid=game_id
gmech_xx=argument1
gmech_yy=argument2
gmech_amt=argument3
//90 gid, tid, user, score
if global.gmech_initialized=1
{
if gmech_tid>0 and gmech_tid<101
{
    if string_count("scoreboard",string(global.gmech_scoreArray[gmech_tid,1]))>0 //Scoreboard doesn't exist
    {
        //draw_text(gmech_xx,gmech_yy,"No scoreboard exists for this game!")
        draw_text(gmech_xx,gmech_yy,"Score                       Player")
        draw_text(gmech_xx,gmech_yy+((gmech_amt+2)*string_height("PGM")),"Powered by GMechanism")
        for(gmech_i=1;gmech_i<=gmech_amt;gmech_i+=1)
        {
            //Display from the gmech_instance local array
            //draw_text(gmech_xx,gmech_yy+(string_height("Powered by GMechanism")*gmech_i),string(global.gmech_scoreArray[gmech_i]))
            //score|player
            gmech_theSc=0
            gmech_thePl="None"
            draw_text(gmech_xx+16,gmech_yy+(string_height("PGM")*gmech_i),string(gmech_theSc))
            draw_text(gmech_xx+150,gmech_yy+(string_height("PGM")*gmech_i),string(gmech_thePl))
        }
    }
    else //The scoreboard can be drawn since it exists
    {
        draw_text(gmech_xx,gmech_yy,"Score                       Player")
        draw_text(gmech_xx,gmech_yy+((gmech_amt+2)*string_height("PGM")),"Powered by GMechanism")
        for(gmech_i=1;gmech_i<=gmech_amt;gmech_i+=1)
        {
            //Display from the gmech_instance local array
            //draw_text(gmech_xx,gmech_yy+(string_height("Powered by GMechanism")*gmech_i),string(global.gmech_scoreArray[gmech_i]))
            //score|player
            gmech_theSc=string_copy(string(global.gmech_scoreArray[gmech_tid,gmech_i]),1,string_pos("|",string(global.gmech_scoreArray[gmech_tid,gmech_i]))-1)
            gmech_thePl=string_copy(string(global.gmech_scoreArray[gmech_tid,gmech_i]),string_pos("|",string(global.gmech_scoreArray[gmech_tid,gmech_i]))+1,string_length(string(global.gmech_scoreArray[gmech_tid,gmech_i])))

            draw_text(gmech_xx+16,gmech_yy+(string_height("PGM")*gmech_i),string(gmech_theSc))
            draw_text(gmech_xx+150,gmech_yy+(string_height("PGM")*gmech_i),string(gmech_thePl))
        }
    }
}
else
{
    draw_text(gmech_xx,gmech_yy,"Illegal table index! (1-100)")
}
}
else
{
    draw_text(gmech_xx,gmech_yy,"Highscores Offline")
}

#define GMech_EncryptFile
var file, byte, pos, key;
file = file_bin_open( argument0, 2);
pos = 1;
while( file_bin_position( file) < file_bin_size( file)) {
    if ( pos <= string_length( argument1)) {
        pos += 1;
    } else pos = 1;
    key = ord( string_char_at( argument1, pos));
    byte = file_bin_read_byte( file);
    file_bin_seek( file, file_bin_position( file) - 1);
    file_bin_write_byte( file, ( byte + key) mod 256);
}
file_bin_close( file);

#define GMech_Free
if global.gmech_initialized=1
{
    GMech_SignOut()
    for(gmech_i=0; gmech_i<=100; gmech_i+=1)
    {
        for(gmech_c=0;gmech_c<=100;gmech_c+=1)
        {
            global.gmech_scoreArray[gmech_i,gmech_c]="0|N/A"
        }
    }
    for(gmech_i=0; gmech_i<=100; gmech_i+=1)
    {
        global.gameAch[gmech_i]=""
    }
}
global.gmech_initialized=0
return true;

#define GMech_GetHighName
g_tid=argument0
g_pos=argument1
if global.gmech_initialized=1
{
    if g_tid>0 and g_tid<101
    {
        if g_pos>0 and g_pos<101
        {
            TheName=string_copy(string(global.gmech_scoreArray[g_tid,g_pos]),string_pos("|",string(global.gmech_scoreArray[g_tid,g_pos]))+1,string_length(string(global.gmech_scoreArray[g_tid,g_pos])))
            TheName=string_replace_all(TheName," ","")
            return TheName;
        }
        else
        {
            return "Invalid position index"
        }
    }
    else
    {
        return "Invalid Table Index"
    }
}
else
{
    return "Highscores offline"
}

#define GMech_GetHighScore
g_tid=argument0
g_pos=argument1
if global.gmech_initialized=1
{
    if g_tid>0 and g_tid<101
    {
        if g_pos>0 and g_pos<101
        {
            gmech_theSc=string_copy(string(global.gmech_scoreArray[g_tid,g_pos]),1,string_pos("|",string(global.gmech_scoreArray[g_tid,g_pos]))-1)
            TheScore=real(gmech_theSc)
            return real(TheScore);
        }
        else
        {
            return -2;
        }
    }
    else
    {
        return -3;
    }
}
else
{
    return -1;
}

#define GMech_GetScoreCount
g_tid=argument0
if global.gmech_initialized=1
{
    if g_tid>0 and g_tid<101
    {
        theCount=0
        for(i=0;i<=100;i+=1)
        {
            thesc=string_copy(string(global.gmech_scoreArray[g_tid,i]),1,string_pos("|",string(global.gmech_scoreArray[g_tid,i]))-1)
            thesc=real(thesc)
            TheName=string_copy(string(global.gmech_scoreArray[g_tid,i]),string_pos("|",string(global.gmech_scoreArray[g_tid,i]))+1,string_length(string(global.gmech_scoreArray[g_tid,i])))
            TheName=string_replace_all(TheName," ","")
            if thesc<>0 and string(TheName)<>"N/A" then theCount+=1
        }
        return real(theCount)+1
    }
    else
    {
        return -2;
    }
}
else
{
    return -1;
}

#define GMech_HasAchievement
g_res=false
if global.gmech_initialized=1
{
    if ds_list_find_index(global.userAch,real(argument0))>(-1) then g_res=true
}
return g_res;

#define GMech_HTML
if os_browser<>browser_not_a_browser then return true else return false

#define GMech_INI_ReadReal
gmech_section=string_lower(argument0)
gmech_key=string_lower(argument1)
gmech_def=real(argument2)
g_ans=gmech_def
if global.gmech_initialized=1
{
    //g_ans=string(GMech_Netread("http://www.gmechanism.com/ini_read_var.php?type=1&user="+string(GMech_Username())+"&gid="+string(game_id)+"&section="+string(gmech_section)+"&key="+string(gmech_key)+"&default="+string(gmech_def),1000))
    ini_open("remote.ini")
    g_ans=ini_read_real(gmech_section,gmech_key,gmech_def)
    ini_close()
    return real(g_ans);
}
else
{
    return real(gmech_def);
}

#define GMech_INI_ReadString
gmech_section=string_lower(argument0)
gmech_key=string_lower(argument1)
gmech_def=string(argument2)
g_ans=gmech_def
if global.gmech_initialized=1
{
    //g_ans=string(GMech_Netread("http://www.gmechanism.com/ini_read_var.php?type=1&user="+string(GMech_Username())+"&gid="+string(game_id)+"&section="+string(gmech_section)+"&key="+string(gmech_key)+"&default="+string(gmech_def),1000))
    ini_open("remote.ini")
    g_ans=ini_read_string(gmech_section,gmech_key,gmech_def)
    ini_close()
    return string(g_ans);
}
else
{
    return real(gmech_def);
}

#define GMech_INI_WriteReal
gmech_section=string_lower(argument0)
gmech_key=string_lower(argument1)
gmech_real=real(argument2)
if global.gmech_initialized=1
{
    http_get("http://www.gmechanism.com/ini_write_var.php?type=1&user="+string(GMech_Username())+"&gid="+string(game_id)+"&section="+string(gmech_section)+"&key="+string(gmech_key)+"&value="+string(gmech_real))
    ini_open("remote.ini")
    ini_write_real(gmech_section,gmech_key,gmech_real)
    ini_close()
    return 1;
}
else
{
    return 0;
}

#define GMech_INI_WriteString
gmech_section=string_lower(argument0)
gmech_key=string_lower(argument1)
gmech_str=string(argument2)
if global.gmech_initialized=1
{
    http_get("http://www.gmechanism.com/ini_write_var.php?type=1&user="+string(GMech_Username())+"&gid="+string(game_id)+"&section="+string(gmech_section)+"&key="+string(gmech_key)+"&value="+string(gmech_str))
    ini_open("remote.ini")
    ini_write_string(gmech_section,gmech_key,gmech_str)
    ini_close()
    return 1;
}
else
{
    return 0;
}

#define GMech_INI_DeleteSection
gmech_section=string_lower(argument0)
if global.gmech_initialized=1
{
    http_get("http://www.gmechanism.com/ini_delete_key.php?type=1&user="+string(GMech_Username())+"&gid="+string(game_id)+"&section="+string(gmech_section)+"&key=")
    ini_open("remote.ini")
    ini_section_delete(gmech_section);
    ini_close();
    return 1;
}
else
{
    return 0;
}

#define GMech_INI_DeleteKey
gmech_section=string_lower(argument0)
gmech_key=string(argument1)
if global.gmech_initialized=1
{
    http_get("http://www.gmechanism.com/ini_delete_key.php?type=1&user="+string(GMech_Username())+"&gid="+string(game_id)+"&section="+string(gmech_section)+"&key="+string(gmech_key))
    ini_open("remote.ini")
    ini_key_delete(gmech_section,gmech_key);
    ini_close()
    return 1;
}
else
{
    return 0;
}

#define GMech_Init
//ARGUMENTS:
//Argument0: Password
//Argument1: GMech instance
//Start all variables
show_debug_message("GMechAPI: Init")
global.gmech_updates=0
global.gmech_username=""
global.gmech_gotScores=0
global.gmech_version="3.2"
global.gmech_playCount=(-1)
global.gmech_initialized=0
global.gmech_publicIP=""
if os_is_network_connected()
{
    show_debug_message("GMechAPI: Net connected!")
    /* No longer legit
    if GMech_Windows() //We're in Windows
    {
        if directory_exists("C:\GMechanism")=0 then directory_create("C:\GMechanism")
        if directory_exists("C:\GMechanism\Cache")=0 then directory_create("C:\GMechanism\Cache")
    }
    */
    http_get("http://www.gmechanism.com/APIGetAccounts.php")
    show_debug_message("GMechAPI: Clean and create GMech Object");
    if (is_real(argument1))
    {
        with(argument1){instance_destroy()}
        if instance_exists(argument1)=0 {object_set_persistent(argument1,true); tc=instance_create(0,0,argument1); object_set_persistent(tc,true); }
    }
    else
    {
        show_debug_message("GMechAPI: FATAL ERROR! Supplied GMech Object identifier is NOT REAL. No communication with the server can take place!")
    }
    show_debug_message("GMechAPI: Assign variables and ds_list")
    http_get("http://www.gmechanism.com/APIVersion.php")
    global.gmech_onlineUserList=ds_list_create()
    global.gmech_blockUsers=ds_list_create() //Keep this the same!
    http_get("http://www.lukeescude.com/ip.php")
    global.gmech_playCount=(-1)
    //global.gmech_defaultAvatar=sprite_add("http://lukeescude.dyndns.org/GMech/avatars/defaultAvatar.png",1,false,true,0,0)
    //Now download game INI
    show_debug_message("GMechAPI: Netread() to get INI")
    http_get("http://www.gmechanism.com/gameINI/getINI.php?gid="+string(game_id))
    show_debug_message("GMechAPI: Create score arrays")
    for(gmech_i=0; gmech_i<=100; gmech_i+=1)
    {
        for(gmech_c=0;gmech_c<=100;gmech_c+=1)
        {
            global.gmech_scoreArray[gmech_i,gmech_c]="0|N/A"
        }
    }
    show_debug_message("GMechAPI: Create achievement arrays")
    for(gmech_i=0; gmech_i<=100; gmech_i+=1)
    {
        global.gameAch[gmech_i]=""
    }
    global.userAch=ds_list_create()
    //Get REGISTERED with argument1
    http_get("http://www.gmechanism.com/APICheckRegistered.php?gid="+string(game_id)+"&pass="+string(argument0))
    //Get HS tables with netread
    global.gmech_initialized=1
    show_debug_message("GMechAPI: UpdateBoards()")
    GMech_UpdateBoards()
    GMech_UpdateAchievements()
    show_debug_message("GMechAPI: Init complete")
    return true;
}
else
{
    global.gmech_initialized=0
    show_debug_message("Internet connection not found!")
    return false;
}

#define GMech_Mac
if os_type=os_macosx and os_browser=browser_not_a_browser then return true else return false

#define GMech_MacDLFile
/*
argument0 = url to download from
argument1 = local file to save as
returns the error code from the server. 200 is a succesful download.

NOTE: urls with usernames and passwords do not work.
*/
var server, file, i, port, tcp, endloop, url, error;
server = "";
file = "/"
port = 80;
i = 0;
error = 200;

if(string_pos("http://", argument0) == 1)argument0 = string_delete(argument0, 1,7)
//get file part of url
i = string_pos("/", argument0);
if(i)
{
    file = string_copy(argument0, i, string_length(argument0)-i+1);
    argument0 = string_delete(argument0, i, string_length(file));
}
//get port part
i = string_pos(":", argument0);
if(i)
{
    port = real(string_copy(argument0, 1, i-1));
    argument0 = string_delete(argument0, 1, i);
}
//get server part
server = argument0;


//the code above interpretes the url into a server variable, file variable and port.
dydllinit()
tcp = dytcpconnect(server, port, 0);
if(!tcp)return false;
dysetformat(tcp, 1, chr(13) + chr(10)); //set format to text mode to receive one line at a time.
//send get request
dyclearbuffer(0);
dywritechars("GET " + file+ " HTTP/1.1" + chr(13) + chr(10),0);
dywritechars("Host: " + server + chr(13) + chr(10),0);
dywritechars("Connection: close"+chr(13) + chr(10),0);
dywritechars("Accept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, application/xaml+xml, application/vnd.ms-xpsdocument, application/x-ms-xbap, application/x-ms-application, application/x-alambik-script, application/x-alambik-alamgram-link, */*"+chr(13)+chr(10),0);
dywritechars("Accept-Language: en-us"+chr(13) + chr(10),0);
dywritechars("User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; InfoPath.1; .NET CLR 2.0.50727; .NET CLR 1.1.4322)"+chr(13) + chr(10),0);
dysendmessage(tcp,0,0,0);
//receive file header

//interpret header for any errors.
endloop = false;
while(!endloop)
{
    dyreceivemessage(tcp,0,0); //receive one line
    i = dyreadsep(" ",0); //read first word
    switch(i)
    {
//check http error code
        case "HTTP/1.1":
        case "HTTP/1.0":
            error = real(dyreadsep(" ",0));
            if(error != 200 && error != 301)
            {
                dyclosesock(tcp);
                return error;
            }
        break;
//if page moved than locate new page and download from it.
        case "Location:":
            if(error == 301)
            {
                dyclosesock(tcp);
                url = dyreadsep(chr(13) + chr(10),0);
                return GMech_MacDLFile(url,argument1);
            }
        break;
//if blank line (end of header) then exit loop
        case "":
            endloop = true
        break;
    }
}
dysetformat(tcp,formatnone,''); //turn off all formatting so we can receive file data.
if(file_exists(argument1))file_delete(argument1);
file = dyfileopen(argument1, 1);
//start receiving file

while(dyreceivemessage(tcp, 50000,0) > 0) //receive 50000 bytes
{
    dyfilewrite(file,0); //write file chunk to file.
}
dyclosesock(tcp);
dyfileclose(file);
return 200;


#define GMech_Netread
/*
Function: Returns the source of an online document.

Arguments:
   0 - string - online document
   1 - real - number of bytes to read
   
Returns:
  string - the source of the document

Example:
  src = netread("http://google.com",5000);
  draw_text(10,10,src);
*/
theRes=""
if GMech_Windows()
{
    act = external_define('NetRead.dll',"NetRead",1,1,2,1,1);
    theRes=external_call(act,argument0,string(argument1));
}
else if GMech_HTML()
{
    theRes=Davejax(argument0,false);
}
else if GMech_Mac()
{
    /*
    res=GMech_MacDLFile(argument0,"tmpFile.txt");
    show_message(string(res))
    if file_exists("tmpFile.txt")
    {
        g_tf=file_text_open_read("tmpFile.txt")
        while(!file_text_eof(g_tf))
        {
            theRes=string(theRes)+file_text_read_string(g_tf)
            file_text_readln(g_tf)
        }
        file_text_close(g_tf)
    }
    */
}
return theRes;

#define GMech_Object_Async
//Get Async stuff
if string_count("APIGetAccounts.php",ds_map_find_value(async_load, "url"))>0
{
    accList = ds_map_find_value(async_load, "result");
    //Write to file
    if file_exists(working_directory+"\acc.dat") then file_delete(working_directory+"\acc.dat")
    f=file_text_open_write(working_directory+"\acc.dat")
    file_text_write_string(f,string(accList))
    file_text_writeln(f)
    file_text_close(f)
}
if string_count("APIVersion.php",ds_map_find_value(async_load, "url"))>0
{
    global.gmech_newestVersion = ds_map_find_value(async_load, "result");
    if GMech_Updates() then show_debug_message("GMechAPI: UPDATE AVAILABLE! Download at www.gmechanism.com")
}
if string_count("ip.php",ds_map_find_value(async_load, "url"))>0
{
    global.gmech_publicIP=string(ds_map_find_value(async_load, "result"))
    show_debug_message("GMechAPI: IP Retrieved")
}
if string_count("getINI.php",ds_map_find_value(async_load, "url"))>0
{
    gini=string(ds_map_find_value(async_load, "result"))
    f=file_text_open_write("remote.ini")
    file_text_write_string(f,gini)
    file_text_writeln(f)
    file_text_close(f)
    show_debug_message("GMechAPI: Obtained GameINI from server")
}
if string_count("APICheckRegistered.php",ds_map_find_value(async_load, "url"))>0
{
    global.gmech_registered=real(ds_map_find_value(async_load, "result"))
    if global.gmech_registered=1
    {
        show_debug_message("GMechAPI: Game is registered!")
        http_get("http://www.gmechanism.com/ini_read_var.php?type=0&user=0&gid="+string(game_id)+"&section="+string(game_id)+"&key=plays&default=-1")
    }
    else
    {
        show_debug_message("GMechAPI: Game is NOT registered!")
    }
}
if string_count("ini_read_var.php",ds_map_find_value(async_load, "url"))>0 //THIS IS NOT UNIQUE! - PLayCount I think
{
    global.gmech_playCount=real(ds_map_find_value(async_load, "result"))
    if global.gmech_playCount>(-1)
    {
        global.gmech_playCount+=1
        http_get("http://www.gmechanism.com/ini_write_var.php?type=0&user=0&gid="+string(game_id)+"&section="+string(game_id)+"&key=plays&value="+string(global.gmech_playCount))
    }
    show_debug_message("GMechAPI: PlayCount established.")
}
if string_count("APIGetScoreboardList.php",ds_map_find_value(async_load,"url"))>0
{
    //WE have a list of boards, create it into an array then fetch those
    
    char=string(chr(13)+chr(10))
    hs=ds_map_find_value(async_load,"result")
    hs=string_replace_all(hs,chr(13),"$")
    hs=string_replace_all(hs,chr(10),"$")
    hs=string_replace_all(hs,"$$","$")
    ct=string_count("$",hs)
    prehs=hs
    localList=ds_list_create()
    for(gmech_c=1;gmech_c<=ct;gmech_c+=1)
    {
        thisUser=string_copy(hs,0,string_pos("$",hs))
        thisUser=string_replace_all(thisUser,"$","")
        hs=string_replace(hs,string(thisUser)+"$","")
        ds_list_add(localList,real(thisUser))
    }
    show_debug_message("GMechAPI: "+string(ds_list_size(localList))+" boards exist. Send request for "+string(prehs))
    for(gmech_d=0;gmech_d<ds_list_size(localList);gmech_d+=1)
    {
        show_debug_message("GMechAPI: Requesting TID "+string(ds_list_find_value(localList,gmech_d)))
        http_get("http://www.gmechanism.com/highscores/APIGetScoreboard.php?gid="+string(game_id)+"&tid="+string(ds_list_find_value(localList,gmech_d)))
    }
}
if string_count("APIGetScoreboard.php",ds_map_find_value(async_load,"url"))>0
{
    //Now get the table ID
    url=ds_map_find_value(async_load,"url")
    tableID=string_copy(url,string_pos("&tid=",url),15)
    tableID=string_replace(tableID,"&tid=","")
    show_debug_message("GMechAPI: Retrieved scoreboard "+string(tableID))
    hs=ds_map_find_value(async_load,"result")
    hs=string_replace_all(hs,chr(13),"$")
    hs=string_replace_all(hs,chr(10),"$")
    hs=string_replace_all(hs,"$$","$")
    ct=string_count("$",hs)
    for(gmech_c=1;gmech_c<=ct;gmech_c+=1)
    {
        thisUser=string_copy(hs,1,string_pos("$",hs))
        thisUser=string_replace_all(thisUser,"$","")
        hs=string_replace(hs,string(thisUser)+"$","")
        thisScore=string_copy(hs,1,string_pos("$",hs))
        thisScore=string_replace_all(thisScore,"$","")
        hs=string_replace(hs,string(thisScore)+"$","") //i is table ID, c is entry
        if string(thisUser)<>""
        {
            global.gmech_scoreArray[tableID,gmech_c]=string(thisScore)+"|"+string(thisUser)
        }
    }
}
if string_count("APIAchDefinitions.php",ds_map_find_value(async_load,"url"))>0
{
    achRaw=ds_map_find_value(async_load,"result")
    achRaw=string_replace_all(achRaw,chr(13),"$")
    achRaw=string_replace_all(achRaw,chr(10),"$")
    achRaw=string_replace_all(achRaw,"$$","$")
    loopAmt=string_count("$",achRaw)/2
    for(gmech_c=1;gmech_c<=loopAmt;gmech_c+=1)
    {
        g_title=string_copy(achRaw,1,string_pos("$",achRaw))
        g_title=string_replace_all(g_title,"$","")
        achRaw=string_replace(achRaw,string(g_title)+"$","")
        g_id=string_copy(achRaw,1,string_pos("$",achRaw))
        g_id=string_replace_all(g_id,"$","")
        achRaw=string_replace(achRaw,string(g_id)+"$","")
        global.gameAch[g_id]=string(g_title)
    }
    show_debug_message("GMechAPI: Game achievement definitions retrieved")
}
if string_count("userAchievements.php",ds_map_find_value(async_load,"url"))>0
{
    achRaw=ds_map_find_value(async_load,"result")
    achRaw=string_replace_all(achRaw,chr(13),"$")
    achRaw=string_replace_all(achRaw,chr(10),"$")
    achRaw=string_replace_all(achRaw,"$$","$")
    loopAmt=string_count("$",achRaw)
    for(gmech_c=1;gmech_c<=loopAmt;gmech_c+=1)
    {
        g_id=string_copy(achRaw,1,string_pos("$",achRaw))
        g_id=string_replace_all(g_id,"$","")
        achRaw=string_replace(achRaw,string(g_id)+"$","")
        if real(g_id)>0 then ds_list_add(global.userAch,real(g_id))
    }
    show_debug_message("GMechAPI: User achievements retrieved")
}
/*
if string_count("APILogin.php",ds_map_find_value(async_load,"url"))>0
{
    res=ds_map_find_value(async_load,"result")
    if (!is_real(res)){res=real(res)}
    switch(res)
    {
        /*
        case 0: //No exist
            return 0;
        break;
        case 1: //Bad pass
            return 2;
        break;
        
        case 2: //SUCCESS
            //Call to online tracker PHP, populate userlists, get INI
            global.gmech_username=string_lower(global.gmech_triedUser)
            http_get("http://www.gmechanism.com/users/userINI.php?user=[USER]"+string(GMech_Username()))
            show_debug_message("GMechAPI: Write returned USER netread() to file")
            GMech_UpdateAchievements()
            GMech_UpdateBoards()
            return true;
        break;
        /*
        case 3: //Banned
            return 3;
        break;
        
    }
    GMech_UpdateAchievements()
    GMech_UpdateBoards()   
}
*/
if string_count("userINI.php",ds_map_find_value(async_load,"url"))>0
{
    gini=string(ds_map_find_value(async_load,"result"))
    f=file_text_open_write("user.ini")
    file_text_write_string(f,gini)
    file_text_writeln(f)
    file_text_close(f)
}
/*
if string_count("APISignup.php",ds_map_find_value(async_load,"url"))>0
{
    res=real(ds_map_find_value(async_load,"result"))
    if res=1
    {
        show_message("Thanks for signing up!")
    }
    else
    {
        show_message("Sorry, that username has been taken!")
    }
}
*/

#define GMech_Object_Create
//Set our alarm code to 30 seconds
object_set_persistent(self,true)

#define GMech_Object_GameEnd
//GameENd stuff
if file_exists(working_directory+"\acc.dat") then file_delete(working_directory+"\acc.dat")

#define GMech_Plays
return global.gmech_playCount;

#define GMech_Profile_GetEmail
g_user=string(GMech_Username())
ret="N/A"
//ret=string(GMech_Netread("http://www.gmechanism.com/ini_read_var.php?type=2&user="+string(g_user)+"&gid="+string(game_id)+"&section=basic&key=email&default=N/A",1000))
if GMech_SignedIn()
{
    ini_open("user.ini")
    ret=string(ini_read_string("basic","email","N/A"))
    ini_close()
}
if string(ret)="NA" then ret="N/A"
return string(ret);

#define GMech_Profile_GetJoined
g_user=string(GMech_Username())
ret="N/A"
//ret=string(GMech_Netread("http://www.gmechanism.com/ini_read_var.php?type=2&user="+string(g_user)+"&gid="+string(game_id)+"&section=basic&key=email&default=N/A",1000))
if GMech_SignedIn()
{
    ini_open("user.ini")
    ret=string(ini_read_string("engine","join","N/A"))
    ini_close()
}
if string(ret)="NA" then ret="N/A"
return string(ret);

#define GMech_Profile_GetLogin
g_user=string(GMech_Username())
ret="N/A"
//ret=string(GMech_Netread("http://www.gmechanism.com/ini_read_var.php?type=2&user="+string(g_user)+"&gid="+string(game_id)+"&section=basic&key=email&default=N/A",1000))
if GMech_SignedIn()
{
    ini_open("user.ini")
    ret=string(ini_read_string("engine","last","N/A"))
    ini_close()
}
if string(ret)="NA" then ret="N/A"
return string(ret);

#define GMech_Profile_GetName
g_user=string(GMech_Username())
ret="N/A"
//ret=string(GMech_Netread("http://www.gmechanism.com/ini_read_var.php?type=2&user="+string(g_user)+"&gid="+string(game_id)+"&section=basic&key=email&default=N/A",1000))
if GMech_SignedIn()
{
    ini_open("user.ini")
    ret=string(ini_read_string("basic","name","N/A"))
    ini_close()
}
if string(ret)="NA" then ret="N/A"
return string(ret);

#define GMech_Profile_GetWebsite
g_user=string(GMech_Username())
ret="N/A"
//ret=string(GMech_Netread("http://www.gmechanism.com/ini_read_var.php?type=2&user="+string(g_user)+"&gid="+string(game_id)+"&section=basic&key=email&default=N/A",1000))
if GMech_SignedIn()
{
    ini_open("user.ini")
    ret=string(ini_read_string("basic","web","N/A"))
    ini_close()
}
if string(ret)="NA" then ret="N/A"
return string(ret);

#define GMech_Profile_ReadReal
g_user=string(GMech_Username())
gmech_key=argument0
gmech_default=argument1
ret="N/A"
ini_open("user.ini")
ret=ini_read_real(string(game_id),string(gmech_key),real(gmech_default))
ini_close()
return real(ret);

#define GMech_Profile_ReadString
g_user=string(GMech_Username())
gmech_key=argument0
gmech_default=argument1
ret="N/A"
ini_open("user.ini")
ret=ini_read_string(string(game_id),string(gmech_key),string(gmech_default))
ini_close()
return string(ret);

#define GMech_Profile_WriteReal
g_user=string(GMech_Username())
gmech_key=string(argument0)
gmech_real=real(argument1)
if global.gmech_initialized=1
{
    http_get("http://www.gmechanism.com/ini_write_var.php?type=2&user="+string(g_user)+"&gid="+string(game_id)+"&section="+string(game_id)+"&key="+string(gmech_key)+"&value="+string(gmech_real))
    ini_open("user.ini")
    ini_write_real(string(game_id),string(gmech_key),real(gmech_real))
    ini_close()
    return 1;
}
else
{
    return 0;
}

#define GMech_Profile_WriteString
g_user=string(GMech_Username())
gmech_key=string(argument0)
gmech_str=string(argument1)
if global.gmech_initialized=1
{
    http_get("http://www.gmechanism.com/ini_write_var.php?type=2&user="+string(g_user)+"&gid="+string(game_id)+"&section="+string(game_id)+"&key="+string(gmech_key)+"&value="+string(gmech_str))
    ini_open("user.ini")
    ini_write_string(string(game_id),string(gmech_key),string(gmech_str))
    ini_close()
    return 1;
}
else
{
    return 0;
}

#define GMech_PublicIP
return string(global.gmech_publicIP)

#define GMech_SignedIn
if string(global.gmech_username)<>""
{
    return true;
}
else
{
    return false;
}

#define GMech_SignIn
g_user=string_lower(argument0)
g_pass=argument1
if GMech_Connected() and file_exists(working_directory+"\acc.dat")
{
    //Check local file
    userExists=false;
    userCorrect=false;
    f=file_text_open_read(working_directory+"\acc.dat")
    while(!file_text_eof(f))
    {
        data_1=file_text_read_string(f)
        file_text_readln(f)
        data_2=file_text_read_string(f)
        file_text_readln(f)
        if string_lower(data_1)=string_lower(g_user) then userExists=true
        if string(data_2)=string(g_pass) then userCorrect=true
    }
    file_text_close(f)
    if userExists
    {
        if userCorrect
        {
            global.gmech_username=string_lower(g_user)
            global.userAch=ds_list_create()
            http_get("http://www.gmechanism.com/users/userINI.php?user=[USER]"+string(GMech_Username()))
            show_debug_message("GMechAPI: Fetch user's INI file")
            http_get("http://www.gmechanism.com/gstats_set.php?user="+string(global.gmech_username)+"&gid="+string(game_id))
            GMech_UpdateAchievements()
            GMech_UpdateBoards()
            return 1;
        }
        else
        {
            return 2;
        }
    }
    else
    {
        return 0;
    }
}
else
{
    return 4;
}

#define GMech_SignOut
if global.gmech_initialized=1
{
    //Send logoff code to server
    GMech_System_UpdateOnlineStatus(false)
    ds_list_destroy(global.userAch)
    //Delete user ini
    if file_exists("user.ini") then file_delete("user.ini")
    global.gmech_username=""
}
return true;

#define GMech_SignUp
g_user=string_lower(argument0)
g_pass=argument1
if GMech_Connected() and file_exists(working_directory+"\acc.dat")
{
    if string_lettersdigits(g_user)<>string(g_user) and string(g_user)<>""
    {
        return 0;
    }
    else
    {
        userExists=false;
        f=file_text_open_read(working_directory+"\acc.dat")
        while(!file_text_eof(f))
        {
            data_1=file_text_read_string(f)
            file_text_readln(f)
            data_2=file_text_read_string(f)
            file_text_readln(f)
            if string(data_1)=string(g_user) then userExists=true
        }
        file_text_close(f)
        if userExists
        {
            return 2;
        }
        else
        {
            f=file_text_open_append(working_directory+"\acc.dat")
            file_text_write_string(f,g_user)
            file_text_writeln(f)
            file_text_write_string(f,g_pass)
            file_text_writeln(f)
            file_text_close(f)
            http_get("http://www.gmechanism.com/APISignup.php?user="+string(g_user)+"&pass="+string(g_pass))
            return 1;
        }
    }
}
else
{
    return 3;
}

#define GMech_SubmitAchievement
if global.gmech_registered=1 and GMech_Connected()
{
    if GMech_SignedIn()
    {
        http_get("http://www.gmechanism.com/userData/submitAchievement.php?user="+string(GMech_Username())+"&gid="+string(game_id)+"&id="+string(argument0))
        ds_list_add(global.userAch,argument0)
    }
}

#define GMech_SubmitHighScore
show_debug_message("GMechAPI: SubmitScore: Assign variables")
gmech_tid=argument0 //Hightscore table slot id
gmech_score=argument1
gmech_gid=game_id
gmech_rev=argument2
//username=argument3
gmech_lboard=argument4
show_debug_message("GMechAPI: SubmitScore: Primary checksum")
gmech_firstinst=string_length(string(gmech_tid))+string_length(string(gmech_score))+string_length(string(gmech_gid))+string_length(string(gmech_rev))
//90 gid, tid, user, score
if GMech_Connected()
{
if gmech_tid>0 and gmech_tid<101
{
    if GMech_SignedIn() or string(argument3)<>""
    {
        if gmech_rev=true or gmech_rev=false
        {
            if GMech_SignedIn() then gmech_user=string(GMech_Username()) else gmech_user=string(argument3)
            if string(gmech_user)<>""
            {  
                show_debug_message("GMechAPI: SubmitScore: Secondary checksum")
                g_check=real(game_id) mod (gmech_firstinst+string_length(string(gmech_user)))
                show_debug_message("GMechAPI: SubmitScore: Go online")
                hstta=http_get("http://www.gmechanism.com/highscores/APISubmitScore.php?gid="+string(game_id)+"&tid="+string(gmech_tid)+"&user="+string(gmech_user)+"&score="+string(gmech_score)+"&rev="+string(gmech_rev)+"&leaderboard="+string(gmech_lboard)+"&checksum="+string(g_check))
                /*
                hs=string_replace_all(hs,chr(13),"$")
                hs=string_replace_all(hs,chr(10),"$")
                hs=string_replace_all(hs,"$$","$")
                for(gmech_c=1;gmech_c<=string_count("$",hs);gmech_c+=1)
                {
                    thisUser=string_copy(hs,1,string_pos("$",hs))
                    thisUser=string_replace_all(thisUser,"$","")
                    hs=string_replace(hs,string(thisUser)+"$","")
                    thisScore=string_copy(hs,1,string_pos("$",hs))
                    thisScore=string_replace_all(thisScore,"$","")
                    hs=string_replace(hs,string(thisScore)+"$","")
                    global.gmech_scoreArray[gmech_tid,gmech_c]=string(thisScore)+"|"+string(thisUser)
                }
                */
                show_debug_message("GMechAPI: SubmitScore: Finished")
                GMech_UpdateBoards()
            }
            else
            {
                show_message("Invalid Guest Username parameter!")
            }
        }
        else
        {
            show_message("Invalid flag: Reversed scoreboard is either true or false")
        }
    }
    else
    {
        show_message("Unable to submit your score, you are not signed in to GMechanism!")
    }
}
else
{
    show_message("Highscore Table ID is invalid! (1-100)")
}
}
else
{
    show_message("GMechanism not connected!")
}

#define GMech_System_UpdateOnlineStatus
//argument0: online (t/f)
/*
if argument0=1 then gstat="n" else gstat="offline"
if GMech_SignedIn()
{
    if GMech_HTML()
    {
        //We can use Davejax async
        //www.lukeescude.com/gmech/setonline.php?user=&gid=12345&ts=n
        k=Davejax("http://www.gmechanism.com/setonline.php?user="+string(GMech_Username())+"&gid="+string(game_id)+"&ts="+string(gstat),true)
    }
    else
    {
        //We use GMStudio async
        http_get("http://www.gmechanism.com/setonline.php?user="+string(GMech_Username())+"&gid="+string(game_id)+"&ts="+string(gstat))
    }
}
*/

#define GMech_UpdateAchievements
show_debug_message("GMechAPI: Update achievement lists")
if GMech_Connected()
{
    //Update our System list of achievements... call defineAchievements.. populate global.gameAch[id]=str
    show_debug_message("GMechAPI: Request game achievement definitions")
    http_get("http://www.gmechanism.com/achievements/APIAchDefinitions.php?gid="+string(game_id))
    //Update user's acheivements... call userAchievements.. populate global.userAch
    if GMech_SignedIn()
    {
        show_debug_message("GMechAPI: Request user achievements")
        http_get("http://www.gmechanism.com/userdata/userAchievements.php?user="+string(GMech_Username())+"&gid="+string(game_id))
    }
    http_get("http://www.gmechanism.com/APIGetAccounts.php")
}

#define GMech_UpdateBoards
show_debug_message("GMechAPI: Clear cached boards")
if GMech_Connected()
{
    for(gmech_i=0; gmech_i<=100; gmech_i+=1)
    {
        for(gmech_c=0;gmech_c<=100;gmech_c+=1)
        {
            global.gmech_scoreArray[gmech_i,gmech_c]="0|N/A"
        }
    }
    show_debug_message("GMechAPI: Fetch the list of boards")
    //Http_get list of boards
    http_get("http://www.gmechanism.com/highscores/APIGetScoreboardList.php?gid="+string(game_id))
    http_get("http://www.gmechanism.com/APIGetAccounts.php")
}

#define GMech_UpdateOnlineUserList
if global.gmech_initialized=1
{
    /*
    show_debug_message("GMechAPI: Clear online user arrays")
    ds_list_clear(global.gmech_onlineUserList)
    show_debug_message("GMechAPI: Get the online users to update")
    if GMech_HTML() then hs=Davejax("http://www.gmechanism.com/setonline.php?user="+string(GMech_Username())+"&gid="+string(game_id)+"&ts=n",false) else hs=GMech_Netread("http://www.gmechanism.com/setonline.php?user="+string(GMech_Username())+"&gid="+string(game_id)+"&ts=n",8000)
    char=string(chr(13)+chr(10))
    show_debug_message("GMechAPI: Got online userlist, parse it.")
    hs=string_replace_all(hs,chr(13),"$")
    hs=string_replace_all(hs,chr(10),"$")
    hs=string_replace_all(hs,"$$","$")
    for(gmech_c=1;gmech_c<=string_count("$",hs);gmech_c+=1)
    {
        thisUser=string_copy(hs,1,string_pos("$",hs))
        thisUser=string_replace_all(thisUser,"$","")
        hs=string_replace(hs,string(thisUser)+"$","")
        ds_list_add(global.gmech_onlineUserList,string(thisUser))
    }
    */
}

#define GMech_Updates
if global.gmech_initialized=1
{
if string(global.gmech_version)<>string(global.gmech_newestVersion) then return 1 else return 0
}
else
{
return 0
}

#define GMech_Username
return string(global.gmech_username)

#define GMech_Windows
if os_type=os_windows and os_browser=browser_not_a_browser then return true else return false

