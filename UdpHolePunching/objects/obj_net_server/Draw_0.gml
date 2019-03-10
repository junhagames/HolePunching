draw_set_color(c_lime);
draw_text(0, 0, "<게임서버>");
draw_set_color(c_white);

draw_text(0, 16,
	string(global.hash) + " | " +
	string(global.serverTitle) + " | " +
	string(global.serverDescription) + " | " +
	string(global.serverMaxPlayer));
draw_text(0, 32, "게임서버 접속자수: " + string(ds_list_size(playerList)));

for (var i = 0; i < ds_list_size(playerList); i++) {
	var playerMap = playerList[| i];
	draw_set_color(c_red);
	draw_text(0, 64 + 16 * (i - 1), 
		string(playerMap[? "hash"]) + " | " +
		string(playerMap[? "name"]) + " | " +
		string(playerMap[? "ip"]) + " | " +
		string(playerMap[? "port"]));
	draw_set_color(c_white);
	draw_set_color(c_white);
}
