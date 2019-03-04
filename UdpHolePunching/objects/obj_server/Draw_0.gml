draw_set_color(c_lime);
draw_text(0, 0, "<" + name + " 게임서버: " + hash + ">");
draw_set_color(c_white);
draw_text(0, 32, "게임서버 접속자수: " + string(ds_list_size(player_list)));

for (var i = 0; i < ds_list_size(player_list); i++) {
	var player_map = player_list[| i];
	draw_set_color(c_red);
	draw_text(0, 100 + 32 * (i + 1), 
		string(player_map[? "hash"]) + " | " +
		string(player_map[? "name"]) + " | " +
		string(player_map[? "ip"]) + " | " +
		string(player_map[? "port"]));
	draw_set_color(c_white);
}

if (!isConnected) {
	draw_set_color(c_yellow);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(room_width / 2, room_height / 2, "마스터서버 연결중...");
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}