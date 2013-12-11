// returns status of the last highscore update
//   0 = successfully submitted score
//   1 = successfully received table without submission
//   2 = wrong password
//   3 = table not found
//   4 = table or types incorrect

return external_call(global.dll_ohs_get_status);
