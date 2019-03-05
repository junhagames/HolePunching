draw_set_color(c_lime);
draw_text(0, 0, "<마스터서버>");
draw_set_color(c_white);
draw_text(0, 32, "플레이어 접속자수: " + string(ds_list_size(playerList)));
draw_text(0, 64, "게임서버 호스팅수: " + string(ds_list_size(serverList)));

for (var i = 0; i < ds_list_size(playerList); i++) {
	var playerMap = playerList[| i];
	draw_set_color(c_red);
	draw_text(0, 100 + 32 * (i + 1), 
		string(playerMap[? "hash"]) + " | " +
		string(playerMap[? "nickName"]) + " | " +
		string(playerMap[? "privateIp"]) + " | " +
		string(playerMap[? "publicIp"]) + " | " +
		string(playerMap[? "port"]) + " | " +
		string(playerMap[? "serverHash"]));
	draw_set_color(c_white);
}

for (var i = 0; i < ds_list_size(serverList); i++) {
	var server_map = serverList[| i];
	draw_set_color(c_blue);
	draw_set_halign(fa_right);
	draw_text(room_width, 100 + 32 * (i + 1),
		string(server_map[? "hash"]) + " | " +
		string(server_map[? "name"]) + " | " +
		string(server_map[? "ip"]) + " | " +
		string(server_map[? "port"]));
	draw_set_color(c_white);
	draw_set_halign(fa_left);
}