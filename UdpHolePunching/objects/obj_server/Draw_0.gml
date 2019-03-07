if (isServerCreate) {
	draw_set_color(c_lime);
	draw_text(0, 0, "<" + global.playerName + " 게임서버: " + global.hash + ">");
	draw_set_color(c_white);
	draw_text(0, 32, "게임서버 접속자수: " + string(ds_list_size(playerList)));

	for (var i = 0; i < ds_list_size(playerList); i++) {
		var playerMap = playerList[| i];
		draw_set_color(c_red);
		draw_text(0, 100 + 32 * (i + 1), 
			string(playerMap[? "hash"]) + " | " +
			string(playerMap[? "name"]) + " | " +
			string(playerMap[? "ip"]) + " | " +
			string(playerMap[? "port"]));
		draw_set_color(c_white);
	}
}
else {
	draw_set_color(c_yellow);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(room_width / 2, room_height / 2, "마스터서버 연결중...");
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}