draw_set_color(c_lime);
draw_text(0, 0, "<마스터서버>");
draw_set_color(c_white);
draw_text(0, 32, "게임서버수: " + string(servers));
draw_text(0, 64, "총접속자수: " + string(players));

for (var i = 0; i < players; i++) {
	draw_set_color(c_red);
	draw_text(0, 100 + 32 * (i + 1), 
		string(ds_map_find_value(player[i], "name")) + " | " +
		string(ds_map_find_value(player[i], "ip")) +  " | " +
		string(ds_map_find_value(player[i], "port")));
	draw_set_color(c_white);
}

for (var i = 0; i < servers; i++) {
	draw_set_color(c_blue);
	draw_set_halign(fa_right);
	draw_text(room_width, 100 + 32 * (i + 1),
		string(ds_map_find_value(server[i], "name")) + " | " +
		string(ds_map_find_value(server[i], "ip")) +  " | " +
		string(ds_map_find_value(server[i], "port")));
	draw_set_color(c_white);
	draw_set_halign(fa_left);
}