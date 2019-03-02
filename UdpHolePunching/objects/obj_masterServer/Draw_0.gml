draw_set_color(c_lime);
draw_text(0, 0, "<마스터서버>");
draw_set_color(c_white);
draw_text(0, 32, "게임서버수: " + string(servers));
draw_text(0, 64, "총접속자수: " + string(players));

for (var i = 0; i < ds_list_size(player_list); i++) {
	var player_map = player_list[| i];
	draw_set_color(c_red);
	draw_text(0, 100 + 32 * (i + 1), 
		string(player_map[? "hash"]) + " | " +
		string(player_map[? "name"]) + " | " +
		string(player_map[? "ip"]) + " | " +
		string(player_map[? "port"]) + " | " +
		string(player_map[? "server"]));
	draw_set_color(c_white);
}

for (var i = 0; i < ds_list_size(server_list); i++) {
	var server_map = server_list[| i];
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